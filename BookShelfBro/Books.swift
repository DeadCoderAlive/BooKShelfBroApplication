//
//  Books+CoreDataProperties.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

enum BookAttributes : String {
    case
    bookTitle   = "bookTitle",
    bookAuthor      = "bookAuthor",
    bookPages      = "bookPages",
    readBook      = "readBook"
    
    
    static let getAll = [
        bookTitle,bookAuthor,bookPages,readBook
    ]
}

@objc(Books)



class Books: NSManagedObject {

    @NSManaged var bookTitle: String?
    @NSManaged var bookAuthor: String?
    @NSManaged var bookPages: String?
    @NSManaged var readBook: String?

}
