//
//  LevelUpView.swift
//  Vitagochi
//
//  Created by Dzulfikar on 20/07/23.
//

import SwiftUI

struct LevelUpView: View {
    @EnvironmentObject var levelUpViewModel: LevelUpViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 8.0) {
            ZStack(alignment: .bottom) {
                Image("LevelUpScreenHeader")
                    .resizable()
                    .scaledToFill()
                
                Image("LevelUpVitaIcon")
                    .background(Color.toHex(hexCode: "FBDAE1"))
                    .clipShape(Circle())
                    .clipped()
                    .overlay(Circle()
                        .stroke(Color.primaryWhite, lineWidth: 6))
                    .shadow(radius: 5)
                    .offset(y: 70)
            }.padding([.bottom], 80)
                
            Group {
                Text("Yippee!✨")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Thanks to you, Vita can get \ncloser to become prettier! ")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    .fontDesign(.rounded)
                
                ProgressView(value: levelUpViewModel.levelProgress, total: levelUpViewModel.maxTotalLevel, label: {
                    Text("Level 1")
                }, currentValueLabel: {
                    Text("\(levelUpViewModel.levelProgress.formatted())/20")
                }).progressViewStyle(LevelUpProgressStyle( height: 16))
                    .padding([.horizontal], 48.0)
                    .padding([.vertical], 32.0)
                
                PrimaryButton(action: {
                    // TODO: Go To Main Screen
                    withAnimation {
                        levelUpViewModel.levelProgress += 1
                    }
                }, input: "Go To Main Screen")
                .padding(.bottom, 64.0)
            }.padding([.horizontal], 32.0)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .fontDesign(.rounded)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.toHex(hexCode: "FBDAE1"), Color.primaryWhite, Color.primaryWhite]), startPoint: .top, endPoint: .bottom)
        )
        
    }
}

struct LevelUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LevelUpView()
                .previewLayout(.sizeThatFits)
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone 14")
                .environmentObject(LevelUpViewModel.singleton)
            
            LevelUpView()
                .previewLayout(.sizeThatFits)
                .previewDevice("iPhone 14 Pro Max")
                .previewDisplayName("iPhone 14 Pro Max")
                .environmentObject(LevelUpViewModel.singleton)
        }
    }
}
