//
//  CustomFont.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya  on 05/11/25.
//

import SwiftUI

struct CustomFont: ViewModifier {
    
    let fontSize: CGFloat
    let fontWeight: Font.Weight
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: fontSize, weight: fontWeight, design: .rounded))
    }
}

extension View {
    func customFont(size: CGFloat, weight: Font.Weight) -> some View {
        self.modifier(CustomFont(fontSize: size, fontWeight: weight))
    }
}
