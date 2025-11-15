//
//  HabitFormfields.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 13/11/25.
//

import SwiftUI

@Observable class HabitFormfields {
    var name: String = ""
    
    var description: String = ""
    
    var progerssColor: Color = .green
    var isReminderActive: Bool = false
    
    var reminderTime: Date = .now
    
    var showIconSheet: Bool = false
    
    var habitIcon: String = "photo"
    
    var compitionPerDay = 1
}

