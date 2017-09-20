//
//  DataService.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import Foundation


class DataService: NSObject {

    static private let defaultQuery = "a"
    private let defaultBatch: UInt = 20

    // MARK: - Properties
    private(set) var books = [Book]()
    private var readBooksIds = [String]()
    private let apiClient = APIClient()

    private var currentQuery: String = defaultQuery
    private var totalAmount: UInt?
    private var lastLoadedIdx: UInt?


    // MARK: - Lyfecycle
    override init() {
        super.init()
        retrieveBooks()
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


    // MARK: - Private
    private func makeAPIRequest() {
        let startIndex = (lastLoadedIdx == nil) ? 0 : lastLoadedIdx! + 1
        apiClient.getBooks(query: currentQuery, startIdx: startIndex, amount: defaultBatch) { [weak self] (response, error) in
            guard let strongSelf = self else {return}
            guard let respDict = response as? Dictionary<String, Any> else {return}
            guard let itemsArray = respDict["items"] as? [Dictionary<String, Any>] else {return}
            strongSelf.totalAmount = respDict["totalItems"] as? UInt
            let books = DataService.booksFromDictArray(array: itemsArray)
            print("")
        }
    }

    private func retrieveBooks() {
        let pathToJSON = Bundle.main.path(forResource: "books", ofType: "json")
        let jsonData = NSData(contentsOfFile: pathToJSON!)! as Data
        do {
            let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
            let items = json["items"] as! [Dictionary<String, Any>]
            books = DataService.booksFromDictArray(array: items).sorted(by: { (book1, book2) -> Bool in
                book1.title.compare(book2.title) == ComparisonResult.orderedAscending
            })
            readBooksIds = DataStorage.getReadBooksIds()
            markReadBooks()
        } catch {
            print("Error. Book retrieval failed")
            books = [Book]()
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

    private func markReadBooks() {
        for bookId in readBooksIds {
            let bookToChange = books.filter { (book) -> Bool in
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
}
