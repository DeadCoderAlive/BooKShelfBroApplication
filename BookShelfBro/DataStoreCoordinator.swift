//
//  DataStoreCoordinator.swift
//  BookShelfBro
//
//  Created by Venkatesh Muthukrishnan on 10/16/15.
//  Copyright © 2015 Srinivasan Sundaramoorthy. All rights reserved.
//

import Foundation
import CoreData

class DataStoreCoordinator: NSObject {
    private let objectModelName = "CoreDataCRUD"
    private let objectModelExtension = "momd"
    private let DBFile = "BookShelfCoreData.sqlite"
    private let appDomain = "com.bookshelf.CRUD"
    
    override init()
    {
        super.init()
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return url[url.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.objectModelName, withExtension: self.objectModelExtension)!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
   lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.DBFile)
    var failureReason = "There was an error creating or loading the application's saved data."
    
    do {
        try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
    } catch {
        // Report any error we got.
        var dict = [String: AnyObject]()
        dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
        dict[NSLocalizedFailureReasonErrorKey] = failureReason
        
        dict[NSUnderlyingErrorKey] = error as NSError
        let wrappedError = NSError(domain: self.appDomain, code: 9999, userInfo: dict)
        
        
        NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        abort()
        
        
    }
    
    return coordinator
    }()

    
    }

 

