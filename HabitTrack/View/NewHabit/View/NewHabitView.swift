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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var habitFormFieldsVM =  HabitFormfields()
    
    @FocusState private var fieldsFocusState: FeildsFocus?
    
    @Environment(DatabaseViewModel.self) var habitDbVM
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                BackgroundColor()
                    
                
                VStack(spacing: 16) {
                    
                    HStack(spacing: 20) {

                        Button {
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.color4)
                                    .frame(width: 80, height: 80)
                                    .overlay {
                                        Image(systemName: habitFormFieldsVM.habitIcon)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundStyle(colorScheme == .light ? .color3 : .color1)
                                            .padding()
                                            .foregroundStyle(.black)
                                    }
                        }

                        CustomSection(headerTilte: "Name") {
                            TextField("", text: $habitFormFieldsVM.name)
                                .padding(.leading)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(.color4)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .focused($fieldsFocusState, equals: .name)
                        }
                    }
                
                    
                    CustomSection(headerTilte: "Description") {
                        TextEditor(text: $habitFormFieldsVM.description)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .scrollContentBackground(.hidden)
                            .padding()
                            .background(.color4)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .focused($fieldsFocusState, equals: .description)
                    }
                    
                    ColorPicker(selection: $habitFormFieldsVM.progerssColor) {
                        HStack(spacing: 10) {
                            Text("Color")
                            
                            ForEach(1..<3) { i in
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(habitFormFieldsVM.progerssColor.opacity( 1.0 / Double(i) ))
                                    .frame(width: 25, height: 25)
                            }
                            
                        }
                    }
                    .customFont(size: 25, weight: .regular)
                    .foregroundStyle(.gray)
                    .padding(10)
                    .background(.color4)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    CustomListCell(placeholder: "Category") {
                        Button {
                            
                        } label: {
                            HStack {
                                Text("None")
                                Image(systemName: "chevron.right")
                            }
                            .foregroundStyle(colorScheme == .light ? .color3 : .color1)
                            .customFont(size: 25, weight: .regular)
                        }
                    }
                
                    
                    CustomSection(headerTilte: "Count: \(habitFormFieldsVM.compitionPerDay)") {
                        
                        Stepper("Complition Per Day", value: $habitFormFieldsVM.compitionPerDay, in: 1...50)
                        .customFont(size: 25, weight: .regular)
                        .foregroundStyle(.gray)
                        .padding(10)
                        .background(.color4)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    
                    Toggle("Reminder", isOn: $habitFormFieldsVM.isReminderActive)
                    .foregroundStyle(.gray)
                    .customFont(size: 25, weight: .regular)
                    .padding(10)
                    .background(.color4)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    if habitFormFieldsVM.isReminderActive {
                        DatePicker("Reminder Timer", selection: $habitFormFieldsVM.reminderTime, displayedComponents: .hourAndMinute)
                            .foregroundStyle(.gray)
                            .customFont(size: 25, weight: .regular)
                            .padding(10)
                            .background(.color4)
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
                
                //TODO: Validation  Before Saving Data/
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let habit = habitFormFieldsVM.createHabit() {
                            habitDbVM.insertRecord(habit: habit)
                            dismissSheet()
                        }
                    } label: {
                        Image(systemName: "checkmark.circle")
                    }
                    .disabled(!habitFormFieldsVM.isNameFieldValid)
                }
            }
            .onTapGesture {
                fieldsFocusState = nil
            }
        }
        
    }
}


#Preview {
    NewHabitView(title: "New Habit")
}



