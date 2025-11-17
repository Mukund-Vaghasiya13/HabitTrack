//
//  HabitFormfields.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 13/11/25.
//

import SwiftUI
internal import CoreData

@Observable class HabitFormfields {
    var name: String = ""
    
    var description: String = ""
    
    var progerssColor: Color = .green
    var isReminderActive: Bool = false
    
    var reminderTime: Date = .now
    
    var showIconSheet: Bool = false
    
    var habitIcon: String = "photo"
    
    var compitionPerDay = 1
    
    
    func createHabit() -> Habit {
        let habit = Habit(context: PersistentManager.shared.context)
        habit.id = UUID()
        habit.name = name
        habit.note = description
        habit.color = "#008000"
        habit.complitionPerDay = Int16(compitionPerDay)
        habit.icon = habitIcon
        habit.reminderTime = reminderTime
        return habit
    }
    
}

