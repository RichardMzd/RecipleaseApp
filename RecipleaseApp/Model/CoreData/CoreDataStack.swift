//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 01/03/2023.
//

import Foundation
import CoreData

open class CoreDataStack {

// MARK: - Propreties
    
    private let name: String
    
// MARK: - Initializer
    
    public init(name: String) {
        self.name = name
    }

// MARK: - Singleton
        
    public lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription)")
            }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
//  MARK: - Method to save
    
    func saveContext() {
        do {
            try mainContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
}

