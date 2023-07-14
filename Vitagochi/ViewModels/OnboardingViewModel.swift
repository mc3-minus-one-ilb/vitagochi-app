//
//  OnboardingViewModel.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import Foundation
import SwiftUI

enum OnboardingRoute: String, Hashable {
    case onboardingSecond
    case onboardingThird
}

class OnboardingViewModel: ObservableObject {
    public static let singleton: OnboardingViewModel = OnboardingViewModel()
    
    @Published var onboardingPath: NavigationPath = NavigationPath()
    
    private var username: String = ""
    public var usernameValue: String { get { return username } }
    
    public func setUsername(data: String) {
        self.username = data
    }
    
    func navigate(route: OnboardingRoute) {
        onboardingPath.append(route)
    }
    
    func backToFirst() {
        onboardingPath.removeLast(onboardingPath.count)
    }
    
    func back() {
        onboardingPath.removeLast(1)
    }
    
    func save(remindSet: Bool) {
        if remindSet {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                
                if let error = error {
                    // Handle the error here.
                    print(error)
                }
                
                // Enable or disable features based on the authorization.
                if granted {
                    // TODO: save the remind time.
                    
                }
                
                DispatchQueue.main.async {
                    GlobalEnvirontment.singleton.setWillingToNotifyState(state: granted)
                    GlobalEnvirontment.singleton.finishOnboarding()
                    self.onboardingPath.removeLast(self.onboardingPath.count)
                }
            }
        } else {
            DispatchQueue.main.async {
                GlobalEnvirontment.singleton.setWillingToNotifyState(state: false)
                GlobalEnvirontment.singleton.finishOnboarding()
                self.onboardingPath.removeLast(self.onboardingPath.count)
            }
        }
    }
}
