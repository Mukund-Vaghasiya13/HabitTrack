//
//  BackgroundColor.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 08/11/25.
//

import SwiftUI

struct BackgroundColor: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if colorScheme == .light {
            Color.color1
                .ignoresSafeArea()
        } else {
            Color.color3
                .ignoresSafeArea()
        }
    }
}

