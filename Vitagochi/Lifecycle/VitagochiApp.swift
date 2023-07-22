//
//  VitagochiApp.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import SwiftUI
import NavigationTransitions

@main
struct VitagochiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var envObj: GlobalEnvirontment = GlobalEnvirontment.singleton
    @StateObject var coreDataEnv: CoreDataEnvirontment = CoreDataEnvirontment.singleton
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel.singleton
    
   
    var body: some Scene {
        WindowGroup {
            if !envObj.isOnboardingFinished {
                NavigationStack(path: $onboardingViewModel.onboardingPath) {
                    OnboardingFirst()
                        .environmentObject(onboardingViewModel)
                        .navigationDestination(for: OnboardingRoute.self, destination: { routes in
                            switch routes {
                            case .OnboardingSecond:
                                OnboardingSecond()
                                    .environmentObject(onboardingViewModel)
                                    .navigationBarBackButtonHidden()
                            case .OnboardingThird:
                                OnboardingThirdRevision()
                                    .environmentObject(onboardingViewModel)
                                    .navigationBarBackButtonHidden()
                            case .OnboardingFourth:
                                OnboardingFourth()
                                    .environmentObject(onboardingViewModel)
                                    .navigationBarBackButtonHidden()
                            }
                        })
                }
                .navigationTransition(.slide(axis: .horizontal), interactivity: .disabled)
            } else {
                    RootView()
                        .environmentObject(coreDataEnv)
                        .environmentObject(envObj)
            }
        }
    }
}

//struct AppView_Previews: PreviewProvider {
//    static var previews: some View {
//        //        ChatView(chatModel: ChatViewModel(photoData: Data()))
//        VitagochiApp()
//    }
//}
