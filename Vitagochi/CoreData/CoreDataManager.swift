//
//  CoreDataManager.swift
//  Vitagochi
//
//  Created by Enzu Ao on 20/07/23.
//

import SwiftUI
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "AppCoreContainer")
        let url = URL.storeURL(for: "group.com.minusone.Vitagochi", databaseName: "AppCoreContainer")
        let storeDescription = NSPersistentStoreDescription(url: url)
        
        container.persistentStoreDescriptions = [storeDescription]
        
        container.loadPersistentStores { description, error  in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving core data . \(error.localizedDescription)")
        }
    }
}
