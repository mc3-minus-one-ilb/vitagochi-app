//
//  TestCoreDataStack.swift
//  VitagochiTests
//
//  Created by Enzu Ao on 20/08/23.
//

import CoreData
import Vitagochi

class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer =  {
        let description = NSPersistentStoreDescription()
        description.url = URL(filePath: "/dev/null")
        let container = NSPersistentContainer(name: "AppCoreContainer")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
