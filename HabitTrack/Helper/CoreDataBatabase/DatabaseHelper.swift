//
//  DatabaseHelper.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 14/11/25.
//

import Foundation
internal import CoreData

//TODO: .xcmodel file and data base name

class PersistentManager {
    
    
    static let shared = PersistentManager()

    
    let persistantManager: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        persistantManager = NSPersistentCloudKitContainer(name: "HabitTrack")
        
        guard let groupURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: AppCresentails.appStorageSuit.rawValue)?
                   .appendingPathComponent("HabitTrack.sqlite")
        else {
            fatalError("❌ App Group directory not found")
        }

        let description = NSPersistentStoreDescription(url: groupURL)
        persistantManager.persistentStoreDescriptions = [description]
        
        persistantManager.loadPersistentStores { description, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            print("📁 Core Data store URL:", groupURL.path)
        }
        
        context = persistantManager.viewContext
    }
}
