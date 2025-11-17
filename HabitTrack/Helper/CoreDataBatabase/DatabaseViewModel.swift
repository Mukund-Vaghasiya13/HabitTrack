//
//  DatabaseViewModel.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 17/11/25.
//

import SwiftUI
internal import CoreData

@Observable class DatabaseViewModel {
    
    var habitRecord: [Habit] = []
    
    func insertRecord(habit: Habit) {
        PersistentManager.shared.context.insert(habit)
        saveAllRecordToDataBase()
    }
    
    init() {
        do {
            try fetchHabitRecord()
        } catch {
            print("Failt to fetch Record")
        }
    }
    
    func saveAllRecordToDataBase() {
        do {
           try PersistentManager.shared.context.save()
           try fetchHabitRecord()
        } catch {
            print(error.localizedDescription)
            print("Fail to Save Record")
        }
    }

    func fetchHabitRecord() throws {
        let request = NSFetchRequest<Habit>(entityName: "Habit")
        self.habitRecord = try PersistentManager.shared.context.fetch(request)
        print(habitRecord[0].name ?? "")
    }
}
