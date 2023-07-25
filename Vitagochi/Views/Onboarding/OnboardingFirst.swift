//
//  OnboardingFirst.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import SwiftUI

struct OnboardingFirst: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 32.0) {
            Text("Vita is here \nfor you!")
                .fontWeight(.bold)
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 16.0)
            
            Text("Do you need someone\n to remind you to eat \ngreens & fruits?")
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Image("OnboardingPearGirl")
                .resizable()
                .scaledToFit()
            
            PrimaryButton(action: {
                onboardingViewModel.navigate(route: .OnboardingSecond)
            }, input: "Absolutely, yes!")
            .padding([.horizontal, .vertical], 32.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            VStack {
                Image("OnboardingPinkWave")
                    .resizable()
                    .frame(maxHeight: UIScreen.fullHeight / 2, alignment: .top)
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
