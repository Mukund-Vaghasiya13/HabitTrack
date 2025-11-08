//
//  NewHabitView.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 08/11/25.
//

import SwiftUI


struct NewHabitView: View {
    
    let title: String
    
    @Environment(\.dismiss) var dismissSheet
    
    @State private var name: String = ""
    
    @State private var description: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                BackgroundColor()
                
                VStack(spacing: 16) {
                    CustomSection(headerTilte: "Name") {
                        TextField("", text: $name)
                            .padding(.leading)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.gray.opacity(0.13))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    CustomSection(headerTilte: "Description") {
                        TextField("", text: $name)
                            .padding(.leading)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color.gray.opacity(0.13))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                
                    Spacer()
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .customFont(size: 23, weight: .bold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                      dismissSheet()
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                      // TODO: Add Data
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                }
            }
        }
        
    }
}


#Preview {
    NewHabitView(title: "New Habit")
}
