//
//  Books.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/17/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import Foundation
import CoreData

enum BookAttributes : String {
    case
    bookTitle  = "bookTitle",
    bookAuthor = "bookAuthor",
    bookPages  = "bookPages",
    readBook   = "readBook",
    barCode    = "barCode"
    
    static let getAll = [
        bookTitle,bookAuthor,bookPages,readBook,barCode
]
}

@objc(Books)

class Books: NSManagedObject {
    @NSManaged var bookAuthor: String?
    @NSManaged var bookPages: String?
    @NSManaged var bookTitle: String?
    @NSManaged var readBook: String?
    @NSManaged var barCode: String?

// Insert code here to add functionality to your managed object subclass

}
