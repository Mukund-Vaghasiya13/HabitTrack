//
//  HabitTrackerApp.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya  on 23/10/25.
//

import SwiftUI

@main
struct HabitTrackApp: App {
    
    @AppStorage("introState") var instroState: IntroState.RawValue = IntroState.introOne.rawValue
    
    @State private var habitDatabaseViewModel = DatabaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let intro = IntroState(rawValue: instroState) {
                switch intro {
                case .introOne:
                    IntroOne()
                case .introTwo:
                    IntroTwo()
                case .introThree:
                    IntroThree()
                case .home:
                    HomeView()
                        .environment(habitDatabaseViewModel)
                }
            } else {
                IntroOne()
            }
        }
    }
}
