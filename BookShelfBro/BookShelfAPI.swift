//
//  BookShelfAPI.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/16/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit
import CoreData

class BookShelfAPI {
    
    let titleNamespace = BookAttributes.bookTitle.rawValue
    
    class var sharedInstance: BookShelfAPI {
        struct Singleton {
            static let instance = BookShelfAPI()
        }
        
        return Singleton.instance
    }
    
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    
  
    func insertIntoDataStore(bookTitle: String!,bookAuthor: String!,bookPages: String!,read: String!){
         let context: NSManagedObjectContext = appDel.managedObjectContext
        let record = NSEntityDescription.insertNewObjectForEntityForName("Books", inManagedObjectContext: context)
        record.setValue(bookTitle, forKey: "bookTitle")
        record.setValue(bookAuthor, forKey: "bookAuthor")
        record.setValue(bookPages, forKey: "bookPages")
        record.setValue(read, forKey: "readBook")
        do {
            try context.save()
        }catch {
            print("could not save")
        }
        
    }
    
    func fetchFromDataStore() ->Array<Books> {
        var fetchedResults:Array<Books> = Array<Books>()
        do {
            let request = NSFetchRequest(entityName: "Books")
            
            let sortDescriptor = NSSortDescriptor(key: titleNamespace,
                ascending: true)
            let sortDescriptors = [sortDescriptor]
            request.sortDescriptors = sortDescriptors
            let context: NSManagedObjectContext = appDel.managedObjectContext
            fetchedResults = try context.executeFetchRequest(request) as! [Books]
            
            
            
           
        } catch {
            print("there are no items")
        }
    return fetchedResults
    }
    
    
}
