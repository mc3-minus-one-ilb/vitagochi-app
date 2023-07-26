//
//  VitagochiApp.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import SwiftUI
import NavigationTransitions
import WidgetKit

@main
struct VitagochiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var envObj: GlobalEnvirontment = GlobalEnvirontment.singleton
    @StateObject var coreDataEnv: CoreDataEnvirontment = CoreDataEnvirontment.singleton
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel.singleton
    @State private var isSplashFinished: Bool = false
   
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
                                    .onDisappear {
                                        isSplashFinished = true
                                    }
                            }
                        })
                }
                .navigationTransition(.slide(axis: .horizontal), interactivity: .disabled)
            } else {
                if self.isSplashFinished {
                    RootView()
                        .environmentObject(coreDataEnv)
                        .environmentObject(envObj)
                        .onAppear{
                            WidgetCenter.shared.reloadTimelines(ofKind: "VitaWidget")
                        }
                } else {
                    SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    self.isSplashFinished = true
                                }
                            }
                        }
                }
            }
        }
    }
}

//struct AppView_Previews: PreviewProvider {
//    static var previews: some Scene {
//        //        ChatView(chatModel: ChatViewModel(photoData: Data()))
//        VitagochiApp()
//    }
//}
