//
//  CoreDataManager.swift
//  FakeCall
//
//  Created by Денис  on 09.11.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared: CoreDataManager = {
        let instance = CoreDataManager()
        // setup code
        return instance
    }()
    
    private init() {}
    
     lazy var context: NSManagedObjectContext = {
        persistentContainer.viewContext
    }()
    
    // Description of the entity
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: context)!
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FakeCall")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}


