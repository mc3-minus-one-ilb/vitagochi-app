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
    
    @State var nickname: String = ""
    @State private var isNicknameEmpty: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Image("OnboardingUpperPrimary")
                .padding([.bottom], 16.0)
            
            Group {
                Group {
                    Text("Now, how should\nVita call you?")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    CounteredTextView(input: $nickname)
                        .onChange(of: Just(nickname), perform: { newValue in
                            if !newValue.output.isEmpty {
                                isNicknameEmpty = false
                            }
                        })
                        .if(isNicknameEmpty, transform: { view in
                            view.overlay(Rectangle()
                                .frame(width: nil, height: 1, alignment: .bottom)
                                .foregroundColor(.red).opacity(1.0), alignment: .bottom)
                        })
                }.padding([.bottom], 16.0)
                
                Spacer()
                
                PrimaryButton(action: {
                    if nickname.isEmpty {
                        isNicknameEmpty = true
                        return
                    }
                    onboardingViewModel.setUsername(data: nickname)
                    onboardingViewModel.navigate(route: .onboardingThird)
                }, input: "Right, just call me that!")
                
                CancelButton(action: {
                    onboardingViewModel.back()
                }, input: "Wait, go back please!")
            }.padding([.horizontal], 32.0)
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
