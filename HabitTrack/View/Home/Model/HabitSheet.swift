//
//  SheetModel.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya  on 05/11/25.
//

import Foundation

enum HabitSheet: Hashable, CaseIterable, Identifiable {
    
    var id: UUID {
        UUID()
    }
    
    case newHabit
    case setting
}
