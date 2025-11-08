//
//  CustomSection.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 08/11/25.
//

import SwiftUI

struct CustomSection<T: View>: View {
    
    let headerTilte: String
    
    let content: () -> T
    
    init(headerTilte: String, @ViewBuilder content: @escaping () -> T) {
        self.headerTilte = headerTilte
        self.content = content
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(headerTilte)
                .customFont(size: 18, weight: .regular)
                .foregroundStyle(.gray)
            
            content()
        }
    }
}
