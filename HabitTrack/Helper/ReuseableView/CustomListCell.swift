//
//  CustomListCell.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 13/11/25.
//

import SwiftUI

struct CustomListCell<T: View> : View {
    
    let content: () ->  T
    
    let placeholder: String
    
    init(placeholder: String, @ViewBuilder content: @escaping () -> T) {
        self.content = content
        self.placeholder = placeholder
    }
    
    var body: some View {
        HStack {
            Text(placeholder)
                .foregroundStyle(.gray)
                .customFont(size: 25, weight: .regular)
            
            Spacer()
            
           content()
        }
        .padding(10)
        .background(.color4)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
