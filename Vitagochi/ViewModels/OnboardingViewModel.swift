//
//  OnboardingViewModel.swift
//  Vitagochi
//
//  Created by Dzulfikar on 12/07/23.
//

import Foundation
import SwiftUI

enum OnboardingRoute: String, Hashable {
    case OnboardingSecond
    case OnboardingThird
    case OnboardingFourth
}

class OnboardingViewModel: ObservableObject {
    public static let singleton: OnboardingViewModel = OnboardingViewModel()
    private let globalEnv: GlobalEnvirontment = GlobalEnvirontment.singleton
    private let notificationHandler: NotificationHandler = NotificationHandler.singleton
    private let coreDataEnv: CoreDataEnvirontment = CoreDataEnvirontment.singleton
    
    @Published var onboardingPath: NavigationPath = NavigationPath()
    
    // Onboarding 2 States
    @Published var nickname: String = ""
    @Published var isNicknameEmpty: Bool = false
    
    // Onboarding 3 States
    @Published var breakfastSelection = Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: .now)!
    @Published var lunchSelection = Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: .now)!
    @Published var dinnerSelection = Calendar.current.date(bySettingHour: 15, minute: 0, second: 0, of: .now)!
    
    
    func navigate(route: OnboardingRoute) {
        onboardingPath.append(route)
    }
    
    func backToFirst() {
        withAnimation(.easeInOut(duration: 1.0)) {
            onboardingPath.removeLast(onboardingPath.count)
        }
    }
    
    func back() {
        onboardingPath.removeLast(1)
    }
    
    func saveUsername() {
        if nickname.isEmpty || isNicknameEmpty {
            self.isNicknameEmpty = true
            return
        }
        
        DispatchQueue.main.async {
            self.globalEnv.setUsername(username: self.nickname)
        }
    }
     
    func handleReminderNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                // Handle the error here.
                print(error)
            }
            
            // Enable or disable features based on the authorization.
            if granted {
                let calendar = Calendar.current
                self.globalEnv.setReminderTime(breakfastTime: HourAndMinute(hour: calendar.component(.hour, from: self.breakfastSelection), minute: calendar.component(.minute, from: self.breakfastSelection)), lunchTime: HourAndMinute(hour: calendar.component(.hour, from: self.lunchSelection), minute: calendar.component(.minute, from: self.lunchSelection)), dinnerTime: HourAndMinute(hour: calendar.component(.hour, from: self.dinnerSelection), minute: calendar.component(.minute, from: self.dinnerSelection)))
            }
            
            DispatchQueue.main.async {
                self.globalEnv.setWillingToNotifyState(state: granted)
                self.navigate(route: .OnboardingFourth)
            }
        }
    }
    
    func finishOnboarding() {
        self.coreDataEnv.add66DaysOfChallanges()
        self.coreDataEnv.getTodayChallange()
        self.globalEnv.finishOnboarding()
        self.notificationHandler.scheduleAppReminderNotification()

        self.onboardingPath.removeLast(self.onboardingPath.count)
    }
    
}
