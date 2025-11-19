//
//  ContentView.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya on 23/10/25.
//

import SwiftUI

@Observable class HabitProgressGridImplimentation {
    
    let currentYear = Calendar.current.component(.year, from: Date())
    
    // MARK: - 1. Find if leap year or not (365 or 366)
    var totalDaysCount: Int {
        let isLeapYear =
            (currentYear % 4 == 0 && currentYear % 100 != 0) || (currentYear % 400 == 0)
        return isLeapYear ? 366 : 365
    }
    
    // MARK: - 2. Find week-day offset of Jan 1
    // Sunday = 1 → offset = 0
    // Monday = 2 → offset = 1
    // Tuesday = 3 → offset = 2   ...etc
    func firstDayWeekOffset() -> Int {
        let calendar = Calendar.current
        let jan1 = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
        let weekday = calendar.component(.weekday, from: jan1)  // Sunday=1
        return weekday - 1  // Convert to 0-based index
    }
    
    // MARK: - 3. Combine: offset + all days
    // This is the REAL GitHub grid logic
    func generateHeatmapDays() -> [Int?] {
        var result: [Int?] = []
        
        let offset = firstDayWeekOffset() // how many empty boxes before day1
        let days = totalDaysCount         // 365 or 366
        
        // Add empty cells before Jan 1 to align the grid to Sunday-start
        for _ in 0..<offset {
            result.append(nil) // nil = empty square 
        }
        
        // Add real day indexes
        for day in 1...days {
            result.append(day) // day number in year
        }
        
        return result
    }
}



struct HomeView: View {
    
    @State private var sheetState: HabitSheet?
    
    @Environment(\.colorScheme) private var colorSchema
    @Environment(DatabaseViewModel.self) var habitDbVM

    @State private var vm = HabitProgressGridImplimentation()
    
    // MARK: - GitHub grid uses 7 rows (Sun to Sat)
    // Each column is 1 week tall
    let rows = [
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundColor()
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(habitDbVM.habitRecord) { value in
                            
                            let days = vm.generateHeatmapDays() // <<< IMPORTANT
                            
                            VStack(spacing: 10) {
                                
                                // Header with icon + name
                                HStack {
                                    Image(systemName: value.icon ?? "flame")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                    
                                    VStack(alignment: .leading) {
                                        Text(value.name ?? "")
                                            .customFont(size: 25, weight: .bold)
                                        
                                        Text(value.note ?? "")
                                            .customFont(size: 16, weight: .regular)
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .foregroundStyle(.color1)
                                            .bold()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
                                        
                                    }
                                    .padding(10)
                                    .background(Color(hex: value.color ?? "#ffffff"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                                
                                // MARK: - GitHub Grid (Horizontal Scroll)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHGrid(rows: rows, spacing: 4) {
                                        ForEach(days.indices, id: \.self) { index in
                                            
                                            if let _ = days[index] {
                                                // MARK: Real day cell
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(Color.green.opacity(0.7)) // Replace with habit progress color
                                                    .frame(width: 15, height: 15)
                                            } else {
                                                // MARK: Empty offset cell (before Jan 1)
                                                RoundedRectangle(cornerRadius: 5)
                                                    .fill(Color.color4)
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity)
                            .background(Color.color4)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    .padding(10)
                }
                
                .navigationTitle("HabitTrack")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        HStack(spacing: 16) {
                            Button { sheetState = .setting } label: {
                                Image(systemName: "gear")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            
                            Button { sheetState = .newHabit } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                    }
                }
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
