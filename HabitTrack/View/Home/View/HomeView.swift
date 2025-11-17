//
//  ContentView.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya  on 23/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var sheetState: HabitSheet?
    
    @Environment(\.colorScheme) private var colorSchema
    @Environment(DatabaseViewModel.self) var habitDbVM
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundColor()
                
                ScrollView(showsIndicators: false) {
                    ForEach(habitDbVM.habitRecord) { value in
                        VStack {
                            Text(value.name ?? "Fail To get name")
                            Text(value.id?.uuidString ?? "Fail to get id")
                        }
                    }
                }
                .navigationTitle("HabitTrack")
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 16) {
                            Button {
                                sheetState = .setting
                            } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Button {
                                sheetState = .newHabit
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }

                        }
                    }
                })
                .padding(.horizontal, 16)
                .sheet(item: $sheetState) { value in
                    switch value {
                    case .newHabit:
                        NewHabitView(title: "Add Habit")
                            .environment(habitDbVM)
                    case .setting:
                        Text("Setting")
                    }
                }
            }
        }
    }
}
