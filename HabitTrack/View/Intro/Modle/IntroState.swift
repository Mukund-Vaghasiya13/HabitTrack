//
//  IntroState.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya  on 27/10/25.
//

import Foundation

enum IntroState: Int {
    case introOne
    case introTwo
    case introThree
    case home
    
    static func saveIntroState(introState: IntroState) {
        UserDefaults.standard.set(introState.rawValue, forKey: "introState")
    }
}


