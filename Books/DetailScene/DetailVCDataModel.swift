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

    private(set) var imageURL: String!
    private(set) var title: String!
    private(set) var authors: String!
    private(set) var subtitle: String!
    private(set) var snippet: String!
    private(set) var description: String!
    private(set) var rating: String!


    // MARK: - Lyfecycle
    init(dataService: DataService) {
        self.dataService = dataService
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
