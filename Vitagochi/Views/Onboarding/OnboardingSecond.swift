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
                    Text("How should Vita\ncall you?")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        
                    
                    CounteredTextView(input: $onboardingViewModel.nickname)
                        .onChange(of: onboardingViewModel.nickname, perform: { newValue in
                            if !newValue.isEmpty {
                                onboardingViewModel.isNicknameEmpty = false
                            }
                        })
                        .if(onboardingViewModel.isNicknameEmpty, transform: { view in
                            view.overlay(Rectangle()
                                .frame(width: nil, height: 1, alignment: .bottom)
                                .offset(y: 8)
                                .foregroundColor(.red).opacity(1.0), alignment: .bottom)
                            
                        })
                }.padding([.bottom], 32.0)
        
                Spacer()
                
                PrimaryButton(action: {
                    onboardingViewModel.saveUsername()
                    onboardingViewModel.navigate(route: .onboardingThird)
                }, input: "Right, just call me that!")
                .fontDesign(.rounded)
                
                CancelButton(action: {
                    onboardingViewModel.isNicknameEmpty =  false
                    onboardingViewModel.back()
                }, input: "Wait, go back please!")
                .fontDesign(.rounded)
                .padding(.top, 8.0)
                .padding([.bottom], 32.0)
                
            }
            .padding([.horizontal], 32.0)
        }
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .kerning(-0.8)
        .edgesIgnoringSafeArea(.top)
        .foregroundColor(.blackGreen)
        
    }
}

struct OnboardingSecond_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSecond()
            .environmentObject(OnboardingViewModel.singleton)
    }
}
