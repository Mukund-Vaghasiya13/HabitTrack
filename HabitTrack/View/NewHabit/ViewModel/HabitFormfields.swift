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
    
    var isNameFieldValid: Bool {
        if name.isEmpty {
            return false
        }
        return true
    }
    
    
    func createHabit() -> Habit?  {
        if isNameFieldValid {
            let habit = Habit(context: PersistentManager.shared.context)
            habit.id = UUID()
            habit.name = name
            habit.note = description
            habit.color = progerssColor.hex
            habit.complitionPerDay = Int16(compitionPerDay)
            habit.icon = habitIcon
            habit.reminderTime = reminderTime
            habit.reminder = isReminderActive
            return habit
        }
        
       return nil
    }
    
}

