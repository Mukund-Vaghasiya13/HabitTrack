//
//  IntroButton.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 09/11/25.
//

import SwiftUI

struct IntroButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    let title: String
    
    var body: some View {
        Text(title)
            .customFont(size: 20, weight: .bold)
            .foregroundStyle(colorScheme == .light ? .color1 : .color3)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(colorScheme == .light ? .color3 : .color1 )
            .cornerRadius(10)
    }
}
