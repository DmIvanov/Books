//
//  DataService.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import Foundation

let dataServiceBooksRefreshedNotification = NSNotification.Name(rawValue: "dataServiceBooksRefreshedNotification")


class DataService {

    static private let defaultQuery = "a"
    private let defaultBatch: UInt = 30

    // MARK: - Properties
    private(set) var books = [Book]()
    private var readBooksIds = [String]()
    private let apiClient = APIClient()

    private var currentQuery: String = defaultQuery
    private var totalAmount: UInt?
    private var lastLoadedIdx: UInt?
    private var loading = false


    // MARK: - Lyfecycle
    init() {
        readBooksIds = DataStorage.getReadBooksIds()
        makeAPIRequest()
    }


    // MARK: - Public
    func changeBookRead(bookId: String) {
        let bookToChange = books.filter { (book) -> Bool in
            book.id == bookId
        }.first
        if bookToChange != nil {
            bookToChange!.read = !bookToChange!.read
            if bookToChange!.read {
                includeBookToRead(bookId: bookId)
            } else {
                excludeBookFromRead(bookId: bookId)
            }
        }
    }

    func loadMoreBooks() {
        makeAPIRequest()
    }

    func loadBooks(query: String) {
        makeAPIRequest(query: query)
    }


    // MARK: - Private
    private func makeAPIRequest(query: String? = nil) {
        let startIndex = (lastLoadedIdx == nil) ? 0 : lastLoadedIdx! + 1
        if loading {
            return
        } else {
            loading = true
        }
        var searchQuery: String
        if query == nil {
            searchQuery = currentQuery
        } else if (query == "") {
            searchQuery = DataService.defaultQuery
        } else {
            searchQuery = query!
        }
        apiClient.getBooks(query: searchQuery, startIdx: startIndex, amount: defaultBatch) { [weak self] (response, error) in
            guard let strongSelf = self else {return}
            strongSelf.loading = false
            if searchQuery != strongSelf.currentQuery {
                strongSelf.currentQuery = searchQuery
                strongSelf.resetBooks()
            }
            guard let respDict = response as? Dictionary<String, Any> else {return}
            guard let itemsArray = respDict["items"] as? [Dictionary<String, Any>] else {return}
            strongSelf.totalAmount = respDict["totalItems"] as? UInt
            let newBooks = DataService.booksFromDictArray(array: itemsArray)
            strongSelf.markReadBooks(booksArray: newBooks)
            strongSelf.addNewBooks(newBooks: newBooks)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: dataServiceBooksRefreshedNotification, object: nil)
            }
        }
    }

    private static func booksFromDictArray(array: [Dictionary<String, Any>]) -> [Book] {
        var result = [Book]()
        for bookDict in array {
            if let book = Book(dictionary: bookDict) {
                result.append(book)
            }
        }
        return result
    }

    private func markReadBooks(booksArray: [Book]) {
        for bookId in readBooksIds {
            let bookToChange = booksArray.filter { (book) -> Bool in
                book.id == bookId
                }.first
            if bookToChange != nil {
                bookToChange!.read = true
            }
        }
    }

    private func includeBookToRead(bookId: String) {
        readBooksIds.append(bookId)
        DataStorage.saveReadBooks(ids: readBooksIds)
    }

    private func excludeBookFromRead(bookId: String) {
        let idx = readBooksIds.index { (id) -> Bool in
            id == bookId
        }
        if idx != nil {
            readBooksIds.remove(at: idx!)
        }
        DataStorage.saveReadBooks(ids: readBooksIds)
    }

    private func addNewBooks(newBooks: [Book]) {
        books.append(contentsOf: newBooks)
        lastLoadedIdx = UInt(books.count - 1)
    }

    private func resetBooks() {
        books = [Book]()
        lastLoadedIdx = nil
        totalAmount = nil
    }
}
