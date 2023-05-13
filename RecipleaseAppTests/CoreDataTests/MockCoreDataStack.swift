//
//  MockCoreDataStack.swift
//  RecipleaseAppTests
//
//  Created by Richard Arif Mazid on 13/04/2023.
//

import Foundation
import RecipleaseApp
import CoreData

final class MockCoreDataStack: CoreDataStack {
    
    convenience init() {
        self.init(name: "Reciplease")
    }
    
    override init(name: String) {
        super.init(name: name)
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: name)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.persistentContainer = container
    }
}
