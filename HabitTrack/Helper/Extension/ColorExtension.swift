//
//  ColorExtension.swift
//  HabitTrack
//
//  Created by Mukund vaghasiya  on 18/11/25.
//

import SwiftUI

//MARK: This Extension  is for Converting Color Into hex string and vice versa.


extension Color {

    // MARK: Init from hex (#RRGGBBAA)
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red   = Double((rgb & 0xFF000000) >> 24) / 255
        let green = Double((rgb & 0x00FF0000) >> 16) / 255
        let blue  = Double((rgb & 0x0000FF00) >> 8)  / 255
        let alpha = Double((rgb & 0x000000FF)) / 255

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    // MARK: Convert Color → hex string (#RRGGBBAA)
    var hex: String {
        let uiColor = UIColor(self)

        guard let components = uiColor.cgColor.components else {
            return "#000000FF"
        }

        let red = Int(components[0] * 255)
        let green = Int(components[1] * 255)
        
        // Some colors have only 2 components (grayscale)
        let blue = Int((components.count > 2 ? components[2] : components[0]) * 255)

        let alpha = Int(uiColor.cgColor.alpha * 255)

        return String(format: "#%02X%02X%02X%02X", red, green, blue, alpha)
    }
    
    
    func progressColorOpacity(i value: Int) -> some View {
        self.opacity( 1.0 / Double(value))
    }
    
}
