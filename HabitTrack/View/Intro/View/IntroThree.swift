//
//  IntroThree.swift
//  HabitTracker
//
//  Created by Mukund vaghasiya on 23/10/25.
//

import SwiftUI

struct IntroThree: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            BackgroundColor()
            
            VStack(spacing: 25) {
                Spacer()
                
                Image(.introOne)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .background(.color2)
                    .clipShape(RoundedRectangle(cornerRadius: 25))

                    
                VStack(spacing: 10) {
                    Text("Track Habits\nRight from Widgets")
                        .customFont(size: 25, weight: .bold)
                        .multilineTextAlignment(.center)
                    
                    Text("Add widgets to your Home Screen for quick habit updates and daily progress.")
                        .customFont(size: 16, weight: .bold)
                        .multilineTextAlignment(.center)
                }
                .foregroundStyle(colorScheme == .light ? .color3 : .color1)
                
                Button {
                    // End of intro — go to main app
                    IntroState.saveIntroState(introState: .home)
                } label: {
                   HabitButton(title: "Get Started")
                }
                .padding(.bottom, 25)
                    
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    IntroThree()
}
