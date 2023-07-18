//
//  OnboardingFourth.swift
//  Vitagochi
//
//  Created by Dzulfikar on 17/07/23.
//

import SwiftUI

struct OnboardingFourth: View {
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("How does Vita work? 👀")
                    .foregroundColor(.primaryWhite)
                    .font(.title)
                    .fontWeight(.bold)
                Image("OnboardingAppleHeader")
                    .resizable()
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
            }
            .padding([.leading], 32.0)
            .frame(maxWidth: .infinity)
            .offset(y: 20)
            VStack {
                Group {
                    HStack(alignment: .top, spacing: 16.0) {
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 48)

                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Vita will remind you")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("In 66 days, Vita will reminds Haris to eat greens and fruits for every breakfast, lunch, and dinner 🍛")
                        }
                    }
                    
                    HStack(alignment: .top, spacing: 16.0) {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 40)
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Vita receive the meal pictures")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("Haris should take a picture of the meals eaten and send it on time to Vita, so that Vita can check it 📸")
                        }
                    }
                    
                    HStack(alignment: .top, spacing: 8.0) {
                        Image(systemName: "wand.and.stars")
                            .resizable()
                            .frame(maxWidth: 50, maxHeight: 40)
                        VStack(alignment: .leading, spacing: 8.0) {
                            Text("Vita will remind you")
                                .font(.title3)
                                .fontWeight(.bold)
                            Text("By regularly taking healthy meal pictures, Vita will level up and there will be badges to be collected! ✨")
                        }
                    }.frame(maxWidth: .infinity)
                }.padding([.vertical], 16.0)
                
                Spacer()
                
                PrimaryButton(action: {
                    onboardingViewModel.finishOnboarding()
                }, input: "Great! Start Now!")
                
                CancelButton(action: {
                    onboardingViewModel.back()
                }, input: "Wait ... go back please")
            }
            .padding([.horizontal, .top], 32.0)
            .padding([.bottom], 48.0)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primaryWhite)
            .cornerRadius(20)
            .shadow(radius: 20)
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color.toHex(hexCode: "ED476B"))
    }
}

struct OnboardingFourth_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFourth()
    }
}
