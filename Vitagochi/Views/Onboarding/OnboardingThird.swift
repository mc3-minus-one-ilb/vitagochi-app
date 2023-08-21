//
//  OnboardingThird.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

enum OnboardingReminderTabs: Hashable {
    case BREAKFAST
    case LUNCH
    case DINNER
}

import SwiftUI

struct OnboardingThird: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    @State private var selectedReminderTab: OnboardingReminderTabs = .BREAKFAST
    @State private var selectedBreakfastHour: Int = 0 // index[7, 8, 9, 10, 11]
    @State private var selectedBreakfastMinute: Int = 0 // index[0...59]
    @State private var selectedBreakfastPeriod: Int = 0 // index["AM", "PM"]
    
    @State private var selectedLunchHour: Int = 0 // index[12, 1, 2, 3)
    @State private var selectedLunchMinute: Int = 0
    @State private var selectedLunchPeriod: Int = 1
    
    @State private var selectedDinnerHour: Int = 0 // index[5, 6, 7, 8, 9]
    @State private var selectedDinnerMinute: Int = 0
    @State private var selectedDinnerPeriod: Int = 1
    
    var body: some View {
        let nickNameCap = onboardingViewModel.nickname.capitalized
        let breakfastHour = [7, 8, 9, 10, 11]
        let lunchHour = [12, 1, 2, 3]
        let dinnerHour = [5, 6, 7, 8, 9]
        let minutes = Array(0...59)
        
        return VStack(alignment: .leading) {
            Image("OnboardingUpperSecondary")
                .padding([.bottom], 16.0)
            
            Group {
                Group {
                    Text("In 66 days, Vita will\nremind \(nickNameCap) on")
                        .font(.title)
                        .fontWeight(.bold)
                }.padding([.bottom], 16.0)
                
                HStack {
                    Text("Breakfast")
                        .padding(.bottom, 8)
                        .if(
                            selectedReminderTab == .BREAKFAST,
                            transform: { view in
                            view.overlay(Rectangle()
                                .frame(width: nil, height: 2, alignment: .bottom)
                                .foregroundColor(.primaryColor)
                                .opacity(1.0), alignment: .bottom)
                            .fontWeight(.bold)
                        })
                            .onTapGesture {
                            selectedReminderTab = .BREAKFAST
                        }
                    Spacer()
                    Text("Lunch")
                        .padding(.bottom, 8)
                        .if(
                            selectedReminderTab == .LUNCH,
                            transform: { view in
                            view
                                .overlay(Rectangle()
                                    .frame(width: nil, height: 2, alignment: .bottom)
                                    .foregroundColor(.primaryColor)
                                    .opacity(1.0), alignment: .bottom)
                                .fontWeight(.bold)
                        })
                            .onTapGesture {
                            selectedReminderTab = .LUNCH
                        }
                    Spacer()
                    Text("Dinner")
                        .padding(.bottom, 8)
                        .if(
                            selectedReminderTab == .DINNER,
                            transform: { view in
                            view.overlay(Rectangle()
                                .frame(width: nil, height: 2, alignment: .bottom)
                                .foregroundColor(.primaryColor)
                                .opacity(1.0), alignment: .bottom)
                            .fontWeight(.bold)
                        })
                            .onTapGesture {
                            selectedReminderTab = .DINNER
                        }
                }
                .font(.title3)
                .foregroundColor(.primaryBlack)
                .frame(maxWidth: .infinity)
                
                TabView(selection: $selectedReminderTab, content: {
                    OnboardingTimePicker(
                        selectedHour: $selectedBreakfastHour,
                        hours: .constant(breakfastHour),
                        selectedMinute: $selectedBreakfastMinute,
                        minutes: .constant(minutes),
                        selectedPeriod: .constant(0))
                        .tag(OnboardingReminderTabs.BREAKFAST)
                        
                    OnboardingTimePicker(
                        selectedHour: $selectedLunchHour,
                        hours: .constant(lunchHour),
                        selectedMinute: $selectedLunchMinute,
                        minutes: .constant(minutes),
                        selectedPeriod: .constant(1))
                        .tag(OnboardingReminderTabs.LUNCH)

                    OnboardingTimePicker(
                        selectedHour: $selectedDinnerHour,
                        hours: .constant(dinnerHour),
                        selectedMinute: $selectedDinnerMinute,
                        minutes: .constant(minutes),
                        selectedPeriod: .constant(1))
                        .tag(OnboardingReminderTabs.DINNER)
                        
                })
                
                Spacer()
                
                PrimaryButton(action: {
                    onboardingViewModel.finishOnboarding()
                }, input: "Ok, start to remind me!")
                
                CancelButton(action: {
                    onboardingViewModel.back()
                }, input: "Hmmm. I’ll set it later")
            }.padding([.horizontal], 32.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.top)
    }
}

struct OnboardingThird_Previews: PreviewProvider {
    static var previews: some View {
        let onboardingViewModel: OnboardingViewModel = OnboardingViewModel.singleton
        
        OnboardingThird()
            .environmentObject(onboardingViewModel)
    }
}
