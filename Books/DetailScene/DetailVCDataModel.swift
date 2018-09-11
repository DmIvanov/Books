//
//  DetailVCDataModel.swift
//  Books
//
//  Created by Dmitrii on 19/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import UIKit

class DetailVCDataModel {

    // MARK: - Properties
    private var dataService: DataService
    private weak var delegate: DetailSceneDelegate?

    private(set) var imageURL: String!
    private(set) var title: String!
    private(set) var authors: String!
    private(set) var subtitle: String!
    private(set) var snippet: String!
    private(set) var description: String!
    private(set) var rating: String!


    // MARK: - Lyfecycle
    init(dataService: DataService, book: Book, delegate: DetailSceneDelegate) {
        self.dataService = dataService
        self.delegate = delegate
        setTheBook(book: book)
    }


    // MARK: - Public
    func setTheBook(book: Book) {
        imageURL = book.imageLink
        title = book.title
        var authorsStr = ""
        for author in book.authors {
            authorsStr += author
            if author != book.authors.last {
                authorsStr += ", "
            }
        }
        authors = authorsStr
        subtitle = book.subtitle
        snippet = book.textSnippet
        description = book.description
        rating = book.averageRating > 0 ? "Book's rating: \(book.averageRating)" : ""
    }
}


protocol DetailSceneDelegate: AnyObject {}
