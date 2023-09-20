//
//  OnboardingThirdRevision.swift
//  Vitagochi
//
//  Created by Dzulfikar on 17/07/23.
//

import SwiftUI

struct OnboardingThirdRevision: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                Text("Set meals schedule!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                Text("Vita will remind \(onboardingViewModel.nickname.capitalized)" +
                     " to eat greens and fruit on:")
                    .font(.title3)
            }
            .padding(.top, 8.0)
            .foregroundColor(.blackGreen)
            
            Spacer()
            
            CollectiveDayTimePicker(timeSelection: $onboardingViewModel.breakfastSelection,
                                    collectiveDayEatingType: .BREAKFAST,
                                    minHour: 7, maxHour: 11)
            
            
            CollectiveDayTimePicker(timeSelection: $onboardingViewModel.lunchSelection,
                                    collectiveDayEatingType: .LUNCH,
                                    minHour: 12,
                                    maxHour: 15)
                .padding([.vertical], 16.0)
            
            CollectiveDayTimePicker(timeSelection: $onboardingViewModel.dinnerSelection,
                                    collectiveDayEatingType: .DINNER,
                                    minHour: 17,
                                    maxHour: 21,
                                    hasDivider: false)
            
            Spacer(minLength: 60)
            
            PrimaryButton(action: {
                onboardingViewModel.handleReminderNotification()
            }, input: "Ok, set the time")
            .padding(.vertical, 16.0)
            
            CancelButton(action: {
                onboardingViewModel.back()
            }, input: "Wait... go back please")
            .padding([.bottom], 32.0)
        }
        .padding([.horizontal], 32.0)
        .padding(.top, 32.0)
        .fontDesign(.rounded)
        .ignoresSafeArea(.keyboard)
        .kerning(-0.8)
    }
}

struct OnboardingThirdRevision_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingThirdRevision()
            .environmentObject(OnboardingViewModel.singleton)
    }
}
