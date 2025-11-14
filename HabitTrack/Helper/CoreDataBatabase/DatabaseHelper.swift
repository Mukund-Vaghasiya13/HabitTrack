//
//  DatabaseHelper.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 14/11/25.
//

import Foundation
import CoreData

//TODO: .xcmodel file and data base name

class PersistentManager {
    
    let persistantManager: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        persistantManager = NSPersistentCloudKitContainer(name: "")
        
        guard let groupURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: AppCresentails.appStorageSuit.rawValue)?
                   .appendingPathComponent("YourDatabase.sqlite")
        else {
            fatalError("❌ App Group directory not found")
        }

        let description = NSPersistentStoreDescription(url: groupURL)
        persistantManager.persistentStoreDescriptions = [description]
        
        persistantManager.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        
        context = persistantManager.viewContext
    }
}
