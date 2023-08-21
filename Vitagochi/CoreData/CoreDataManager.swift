//
//  CoreDataManager.swift
//  Vitagochi
//
//  Created by Enzu Ao on 20/07/23.
//

import SwiftUI
import CoreData

enum StorageType {
    case persistent, inMemory
}

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(_ storageType: StorageType = .persistent) {
        self.container = NSPersistentContainer(name: "AppCoreContainer")
        
        switch storageType {
        case.persistent:
            let url = URL.storeURL(for: "group.com.minusone.Vitagochi",
                                   databaseName: "AppCoreContainer")
            let storeDescription = NSPersistentStoreDescription(url: url)
        
            self.container.persistentStoreDescriptions = [storeDescription]
            
        case.inMemory:
            let storeDescription = NSPersistentStoreDescription()
            storeDescription.type = NSInMemoryStoreType
            
            self.container.persistentStoreDescriptions = [storeDescription]
        }
        
        self.container.loadPersistentStores { _, error  in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        self.context = self.container.viewContext
    }
    
    func save() {
        do {
            try self.context.save()
        } catch {
            print("Error saving core data . \(error.localizedDescription)")
        }
    }
}
