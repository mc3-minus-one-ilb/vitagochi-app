//
//  LevelUpView.swift
//  Vitagochi
//
//  Created by Dzulfikar on 20/07/23.
//

import SwiftUI

struct LevelUpView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @EnvironmentObject private var coreDataEnv: CoreDataEnvirontment
    @StateObject private var levelUpVM: LevelUpViewModel = LevelUpViewModel()
    
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
                
                if levelUpVM.isEvolving {
                    Text("Finally, Vita can evolve!\nYou are the best! Keep it up ✊🏻  ")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .fontDesign(.rounded)
                } else if !coreDataEnv.isAnotherTodayMealRecord() {
                    Text("Thanks to you, Vita can get \ncloser to become prettier! ")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .fontDesign(.rounded)
                } else {
                    Text("Thanks buddy! Note that\nyou've been level up today!")
                        .multilineTextAlignment(.center)
                        .font(.title3)
                        .fontDesign(.rounded)
                }
                
                if !levelUpVM.isLevelUp {
                    ProgressView(
                        value: levelUpVM.levelProgress,
                        total: levelUpVM.maxTotalLevel,
                        label: { Text("Level \(levelUpVM.level)") },
                        currentValueLabel: {
                            Text("\(levelUpVM.levelProgress.formatted())/20")
                        }
                    ).progressViewStyle(LevelUpProgressStyle( height: 16))
                        .padding([.horizontal], 48.0)
                        .padding([.vertical], 32.0)
                    
                } else {
                    ProgressView(value: 0, total: 20, label: {
                        VStack(alignment: .leading) {
                            Text("Level \(levelUpVM.level) ⬆️")
                        }
                    }, currentValueLabel: {
                        Text("\(0)/20")
                    }).progressViewStyle(LevelUpProgressStyle( height: 16))
                        .padding([.horizontal], 48.0)
                        .padding([.vertical], 32.0)
                        .animation(.easeIn(duration: 1.0),
                                   value: levelUpVM.isLevelUp)
                    
                }
                
                PrimaryButton(action: {
                    envObj.toggleLevelUpViewNav()
                    envObj.toggleChatViewNav()
                }, input: "Go To Main Screen")
                .padding(.bottom, 64.0)
                
            }.padding([.horizontal], 32.0)
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .fontDesign(.rounded)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                gradient:
                    Gradient(colors: [Color.toHex(hexCode: "FBDAE1"),
                                      Color.primaryWhite,
                                      Color.primaryWhite]),
                startPoint: .top, endPoint: .bottom)
        )
        .onAppear {
            let progress = coreDataEnv.levelProgress()
            let tempVitaModel = coreDataEnv.vitaSkinModel
            levelUpVM.level = tempVitaModel.rawValue + 1
            coreDataEnv.getVitaModel()
            
            if coreDataEnv.vitaSkinModel != tempVitaModel {
                levelUpVM.isEvolving.toggle()
                // Start animation after 2 second
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation(.easeOut(duration: 1.0)) {
                        levelUpVM.level = coreDataEnv.vitaSkinModel.rawValue + 1
                        levelUpVM.isLevelUp.toggle()
                    }
                }
            }
            
            if  !coreDataEnv.isAnotherTodayMealRecord() {
                withAnimation(.easeInOut(duration: 1.5)) {
                    levelUpVM.levelProgress += progress
                }
            } else {
                levelUpVM.levelProgress += progress
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct LevelUpView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LevelUpView()
                .previewLayout(.sizeThatFits)
                .previewDevice("iPhone 14")
                .previewDisplayName("iPhone 14")
                .environmentObject(CoreDataEnvirontment.singleton)
                .environmentObject(GlobalEnvirontment.singleton)
            //
            //            LevelUpView()
            //                .previewLayout(.sizeThatFits)
            //                .previewDevice("iPhone 14 Pro Max")
            //                .previewDisplayName("iPhone 14 Pro Max")
            //                .environmentObject(LevelUpViewModel.singleton)
        }
    }
}
