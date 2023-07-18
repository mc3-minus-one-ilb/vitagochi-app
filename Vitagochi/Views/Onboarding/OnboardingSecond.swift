//
//  OnboardingSecond.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import SwiftUI
import Combine

struct OnboardingSecond: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("OnboardingUpperPrimary")
                .padding([.bottom], 16.0)
            
            Group {
                Group {
                    Text("Now, how should\nVita call you?")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    CounteredTextView(input: $onboardingViewModel.nickname)
                        .onChange(of: onboardingViewModel.nickname, perform: { newValue in
                            if !newValue.isEmpty {
                                onboardingViewModel.isNicknameEmpty = false
                            }
                        })
                        .if(onboardingViewModel.isNicknameEmpty, transform: { view in
                            view.overlay(Rectangle()
                                .frame(width: nil, height: 1, alignment: .bottom)
                                .foregroundColor(.red).opacity(1.0), alignment: .bottom)
                        })
                }.padding([.bottom], 16.0)
                
                Spacer()
                
                PrimaryButton(action: {
                    if onboardingViewModel.nickname.isEmpty || onboardingViewModel.isNicknameEmpty {
                        onboardingViewModel.isNicknameEmpty = true
                        return
                    }
                    onboardingViewModel.navigate(route: .OnboardingThird)
                }, input: "Right, just call me that!")
                
                CancelButton(action: {
                    onboardingViewModel.back()
                }, input: "Wait, go back please!")
                .padding(.top, 8.0)
                .padding([.bottom], 32.0)
            }
            .padding([.horizontal], 32.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .edgesIgnoringSafeArea(.top)
        .ignoresSafeArea(.keyboard)
    }
}

struct OnboardingSecond_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSecond()
            .environmentObject(OnboardingViewModel.singleton)
    }
}
