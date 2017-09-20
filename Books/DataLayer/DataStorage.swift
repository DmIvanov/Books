//
//  DataStorage.swift
//  Books
//
//  Created by Dmitrii on 19/09/2017.
//  Copyright © 2017 DI. All rights reserved.
//

import Foundation


let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
let BooksArchiveURL = DocumentsDirectory.appendingPathComponent("ReadBooks")


class DataStorage {

    static func getReadBooksIds() -> [String] {
        guard let ids = NSKeyedUnarchiver.unarchiveObject(withFile: BooksArchiveURL.path) as? [String] else {return [String]()}
        return ids
    }

    static func saveReadBooks(ids: [String]) {
        NSKeyedArchiver.archiveRootObject(ids, toFile: BooksArchiveURL.path)
    }
    
}
