//
//  BookShelfAPI.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/16/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import UIKit
import CoreData

//CRUD API which makes it persistent
class BookShelfAPI {
    
    let titleNamespace = BookAttributes.bookTitle.rawValue
    //Instace sharing
    class var sharedInstance: BookShelfAPI {
        struct Singleton {
            static let instance = BookShelfAPI()
        }
        
        return Singleton.instance
    }
    //Application delegate created to which is used to call the context manager
    let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    
  //insertion function into the persistent datastore
    func insertIntoDataStore(bookTitle: String!,bookAuthor: String!,bookPages: String!,read: String!,barCode: String!)->Bool{
         let context: NSManagedObjectContext = appDel.managedObjectContext
        let record = NSEntityDescription.insertNewObjectForEntityForName("Books", inManagedObjectContext: context)
        record.setValue(bookTitle, forKey: "bookTitle")
        record.setValue(bookAuthor, forKey: "bookAuthor")
        record.setValue(bookPages, forKey: "bookPages")
        record.setValue(read, forKey: "readBook")
        record.setValue(barCode, forKey: "barCode")
        do {
            try context.save()
            return true
        }catch {
            print("could not save")
            return false
        }
        
    }
    
    //fetch from the persistent datastore essentially CoreData
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
