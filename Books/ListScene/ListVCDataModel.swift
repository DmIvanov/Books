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
    private var booksToDisplay = [Book]()

    private weak var delegate: ListSceneDelegate?
    private weak var viewController: ListVC?

    private(set) var dataService: DataService
    private(set) var justTopRated = false


    // MARK: - Lyfecycle
    init(dataService: DataService, viewController: ListVC, delegate: ListSceneDelegate) {
        self.dataService = dataService
        self.viewController = viewController
        self.delegate = delegate
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

    func bookWasChosen(index: Int) {
        guard let model = model(index: index) else { return }
        guard let book = book(forId: model.bookID) else { return }
        delegate?.bookWasChosen(book: book)
    }
    // MARK: - Private
    private func tryToLoadMore() {
        dataService.loadMoreBooks()
    }
}


protocol ListSceneDelegate: AnyObject {
    func bookWasChosen(book: Book)
}
