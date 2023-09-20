//
//  OnboardingFirst.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import SwiftUI

// TODO: Change Onboarding
struct OnboardingFirst: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 32.0) {
            Text("Vita is here")
                .fontWeight(.bold)
                .fontDesign(.rounded)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.blackGreen)
                .padding(.top, 16.0)
            
            Text("Remind you to eat\n" +
                 "healthy meals on time\n" +
                 "3 times a day!")
                .font(.title3)
                .fontDesign(.rounded)
                .foregroundColor(.blackGreen)
                .multilineTextAlignment(.center)
            
            Image("OnboardingPearGirl")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.9)
            
            PrimaryButton(action: {
                onboardingViewModel.navigate(route: .onboardingSecond)
            }, input: "Okay! Let's Go!")
            .fontDesign(.rounded)
            .padding([.horizontal, .vertical], 32.0)
            .offset(y: -20)
        }
        .kerning(-0.8)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            VStack {
                Image("OnboardingGreensAndFruits")
                    .resizable()
                    .frame(maxHeight: UIScreen.fullHeight * 0.55, alignment: .center)
                    .offset(y: UIScreen.fullHeight * 0.25)
                Spacer()
            }.edgesIgnoringSafeArea(.top)
        )
        .background(Color.primaryWhite)
        
    }
}

struct OnboardingFirst_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirst()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        OnboardingFirst()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
    }
}
