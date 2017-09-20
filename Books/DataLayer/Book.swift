//
//  Book.swift
//  Books
//
//  Created by Dmitrii on 19/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

class Book {

    let id: String
    let title: String
    let authors: [String]
    let imageLink: String
    let subtitle: String
    let averageRating: Double
    let description: String
    let textSnippet: String
    var read = false

    init?(dictionary: Dictionary<String, Any>) {
        guard let volumeInfo = dictionary["volumeInfo"] as? Dictionary<String, Any> else {return nil}
        guard let searchInfo = dictionary["searchInfo"] as? Dictionary<String, Any> else {return nil}
        guard let imageLinks = volumeInfo["imageLinks"] as? Dictionary<String, Any> else {return nil}
        guard let identifier = dictionary["id"] as? String else {return nil}
        id = identifier
        authors = volumeInfo["authors"] as? [String] ?? [String]()
        title = volumeInfo["title"] as? String ?? ""
        imageLink = imageLinks["thumbnail"] as? String ?? ""
        subtitle = volumeInfo["subtitle"] as? String ?? ""
        description = volumeInfo["description"] as? String ?? ""
        textSnippet = searchInfo["textSnippet"] as? String ?? ""
        averageRating = volumeInfo["averageRating"] as? Double ?? 0.0
    }
}
