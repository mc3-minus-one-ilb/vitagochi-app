//
//  VitagochiApp.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import SwiftUI

@main
struct VitagochiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var envObj: GlobalEnvirontment = GlobalEnvirontment.singleton
    @StateObject var onboardingViewModel: OnboardingViewModel = OnboardingViewModel.singleton
    
    var body: some Scene {
        WindowGroup {
            if !envObj.isOnboardingFinished {
                NavigationStack(path: $onboardingViewModel.onboardingPath) {
                    OnboardingFirst()
                        .environmentObject(onboardingViewModel)
                        .navigationDestination(for: OnboardingRoute.self, destination: { routes in
                            switch routes {
                            case .onboardingSecond:
                                OnboardingSecond()
                                    .environmentObject(onboardingViewModel)
                                    .navigationBarBackButtonHidden()
                            case .onboardingThird:
                                OnboardingThird()
                                    .environmentObject(onboardingViewModel)
                                    .navigationBarBackButtonHidden()
                            }
                        })
                }
            } else {
                Text("ASD")
            }
        }
    }
}
