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
            
            Text("Do you need someone\n to remind you to eat \ngreens & fruits?")
                .font(.title3)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            
            Image("OnboardingPearGirl")
            
            PrimaryButton(action: {
                onboardingViewModel.navigate(route: .onboardingSecond)
            }, input: "Absolutely, yes!")
            
        }
        .padding([.horizontal], 32.0)
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
    }
}
