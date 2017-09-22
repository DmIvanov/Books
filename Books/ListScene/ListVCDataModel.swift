//
//  ListVCDataModel.swift
//  Books
//
//  Created by Dmitrii on 18/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import Foundation

class ListVCDataModel {

    // MARK: - Properties
    private(set) var dataService: DataService
    private var booksToDisplay = [Book]()
    private(set) var justTopRated = false


    // MARK: - Lyfecycle
    init(dataService: DataService) {
        self.dataService = dataService
        refreshBooksArray()
    }


    // MARK: - Public
    func booksAmount() -> Int {
        return booksToDisplay.count
    }

    func model(index: Int) -> ListCellModel? {
        guard index >= 0 && index < booksToDisplay.count else {return nil}
        if booksToDisplay.count - index < 10 {
            tryToLoadMore()
        }
        return ListCellModel(book: booksToDisplay[index], idx: UInt(index))
    }

    func changeTopRated() {
        justTopRated = !justTopRated
        refreshBooksArray()
    }

    func changeBookRead(bookId: String) {
        dataService.changeBookRead(bookId: bookId)
    }

    func book(forId: String) -> Book? {
        let resultBook = booksToDisplay.filter { (book) -> Bool in
            book.id == forId
            }.first
        return resultBook
    }

    func refreshBooksArray() {
        if justTopRated {
            booksToDisplay = dataService.books.filter({ (book) -> Bool in
                book.averageRating >= 4.0
            })
        } else {
            booksToDisplay = dataService.books
        }
    }

    func loadBooks(query: String) {
        dataService.loadBooks(query: query)
    }

    // MARK: - Private
    private func tryToLoadMore() {
        dataService.loadMoreBooks()
    }
}

