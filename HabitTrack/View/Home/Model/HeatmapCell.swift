//
//  HeatmapCell.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 22/11/25.
//

import Foundation

struct HeatmapCell: Identifiable {
    
    let id: Int
    let day: Int?           // nil = empty cell
    var progress: Double    // 0 = no progress
}
