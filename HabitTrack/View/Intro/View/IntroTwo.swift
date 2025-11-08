//
//  IntroTwo.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya on 23/10/25.
//

import SwiftUI

struct IntroTwo: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
           BackgroundColor()
            
            VStack(spacing: 25) {
                Spacer()
                
                Image(.intorTwo) // Add your image to Assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                    .background(.color2)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                VStack(spacing: 10) {
                    Text("Stay on Track\nwith Notifications")
                        .customFont(size: 25, weight: .bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Get gentle reminders to complete your daily goals right on time!")
                        .customFont(size: 16, weight: .bold)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(colorScheme == .light ? .color3 : .color1)
                
                Button {
                    IntroState.saveIntroState(introState: .introThree)
                } label: {
                    HabitButton(title: "Continue")
                }
                .padding(.bottom, 25)
                    
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    IntroTwo()
}
