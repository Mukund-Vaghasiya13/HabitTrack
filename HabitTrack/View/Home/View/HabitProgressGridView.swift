//
//  HabitProgressGridView.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 22/11/25.
//

import SwiftUI

struct HabitProgressGridView: View {

    @State private var vm: HabitProgressGridImplimentation

    @Environment(DatabaseViewModel.self) var habitDB
    
    init(habit: Habit) {
        _vm = State(wrappedValue: HabitProgressGridImplimentation(habit: habit))
    }
    
    var body: some View {
        VStack(spacing: 10) {
            
            // Header with icon + name
           
            hearderView
            
            // MARK: - GitHub Grid (Horizontal Scroll)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: vm.rows, spacing: 4) {
                    ForEach(vm.habitHeatMapRecord) { data in
                        Group {
                            if let _ = data.day, data.progress != 0 {
                                Color(hex: vm.habit.color ?? "#ffffff").opacity(vm.claculateOpactity(totalCount: vm.habit.complitionPerDay, DoneCount: data.progress))
                                    .frame(width: 15, height: 15)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            } else {
                                Color.color4
                                    .frame(width: 15, height: 15)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                            }
                        }
                        .id(data.id)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: .constant(vm.currentDay), anchor: .center)
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color.color4)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var hearderView: some View {
        HStack {
            Image(systemName: vm.habit.icon ?? "flame")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(vm.habit.name ?? "")
                    .customFont(size: 25, weight: .bold)
                
                Text(vm.habit.note ?? "")
                    .customFont(size: 16, weight: .regular)
            }
            
            Spacer()
            
            Button {
                vm.updateHabitProgress()
            } label: {
                Image(systemName: "checkmark")
                    .resizable()
                    .foregroundStyle(.color1)
                    .bold()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
            }
            .padding(10)
            .background(Color(hex: vm.habit.color ?? "#ffffff"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
