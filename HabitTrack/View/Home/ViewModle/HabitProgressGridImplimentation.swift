//
//  HabitProgressGridImplimentation.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 22/11/25.
//

import SwiftUI
internal import CoreData

@Observable class HabitProgressGridImplimentation {
    
    let currentYear = Calendar.current.component(.year, from: Date())
    
    var currentDay: Int {
        Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 1
    }
    
    let habit: Habit
    
    var habitHeatMapRecord: [HeatmapCell] = []
    
    init(habit: Habit) {
        self.habit = habit
        self.habitHeatMapRecord = buildHeatmap()
    }

    let rows = [
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
        GridItem(.fixed(15)),
    ]

    var totalDaysCount: Int {
        let isLeapYear =
            (currentYear % 4 == 0 && currentYear % 100 != 0) || (currentYear % 400 == 0)
        return isLeapYear ? 366 : 365
    }
    
    // MARK: - 2. Find week-day offset of Jan 1
    func firstDayWeekOffset() -> Int {
        let calendar = Calendar.current
        let jan1 = calendar.date(from: DateComponents(year: currentYear, month: 1, day: 1))!
        let weekday = calendar.component(.weekday, from: jan1)  // Sunday=1
        return weekday - 1  // Convert to 0-based index
    }
    
    private func filterCurrentYearAndGet(habit: Habit) -> [Int: Double] {
        let calendar = Calendar.current
        
        guard let records = habit.progress as? Set<HabitProgress> else {
            return [:]
        }
        
        return Dictionary(
            uniqueKeysWithValues:
                records
                .compactMap { record -> (Int, Double)? in
                    guard
                        let date = record.date,
                        calendar.component(.year, from: date) == currentYear,
                        let day = calendar.ordinality(of: .day, in: .year, for: date)
                    else { return nil }
                    
                    return (day, Double(record.dailycount))
                }
        )
    }
    
    private func buildHeatmap() -> [HeatmapCell] {
        let offset = firstDayWeekOffset()
        let daysInYear = totalDaysCount
        let progressMap = filterCurrentYearAndGet(habit: habit)

        var result: [HeatmapCell] = []

        // Offset cells
        for i in 0..<offset {
            result.append(HeatmapCell(id: -i-1, day: nil, progress: 0))
        }

        // Real days
        for day in 1...daysInYear {
            result.append(
                HeatmapCell(id: day, day: day, progress: progressMap[day] ?? 0)
            )
        }

        return result
    }


    func claculateOpactity(totalCount: Int16, DoneCount: Double) -> Double {
        if totalCount == 0 {
            return 0.0
        }
        return DoneCount / Double(totalCount)
    }

    
    func updateHabitProgress() {
        
        guard let habitProgress = habit.progress as? Set<HabitProgress> else {
            return
        }
        
        if let todayHabitProgress = habitProgress.first(where: { Calendar.current.isDate($0.date ?? .now, inSameDayAs: Date()) }) {
            if todayHabitProgress.dailycount <=  habit.complitionPerDay {
                todayHabitProgress.dailycount += 1
            }
        } else {
            let habitProgress = HabitProgress(context: PersistentManager.shared.context)
            habitProgress.id = UUID()
            habitProgress.date = Date()
            habitProgress.dailycount = 1
            habitProgress.habit = habit
        }
        
        do {
            try PersistentManager.shared.context.save()
            if let index = habitHeatMapRecord.firstIndex(where: { $0.day == currentDay }), habitHeatMapRecord[index].progress <= Double(habit.complitionPerDay) {
                habitHeatMapRecord[index].progress += 1.0
            }
        } catch {
            print("Fail to Save Habit Progress")
        }
    }
}
