//
//  IntroOne.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya  on 23/10/25.
//

import SwiftUI

struct IntroOne: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            BackgroundColor()
            
            VStack(spacing: 25) {
                Spacer()
                
                Image(.introOne)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    
                VStack(spacing: 10) {
                    Text("Create Your Own\nHabit")
                        .customFont(size: 25, weight: .bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Track your passions, build new habits, and make every day creative!")
                        .customFont(size: 16, weight: .bold)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(colorScheme == .light ? .color3 : .color1)
                
                Button {
                    IntroState.saveIntroState(introState: .introTwo)
                } label: {
                    IntroButton(title: "Continue")
                }
                .padding(.bottom, 25)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    IntroOne()
}
