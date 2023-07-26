//
//  GlobalEnvirontment.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import SwiftUI

enum MainRoute: String, Hashable {
    case Root
    case Chat
    case Level
}

class GlobalEnvirontment: ObservableObject {
    static var singleton = GlobalEnvirontment()
    
    @Published var username: String = ""
    @Published var isOnboardingFinished: Bool = false
    @Published var willingToNotify: Bool = false
    
    @Published var breakfastReminder: HourAndMinute = HourAndMinute(hour: 7, minute: 0)
    @Published var lunchReminder: HourAndMinute = HourAndMinute(hour: 12, minute: 0)
    @Published var dinnerReminder: HourAndMinute = HourAndMinute(hour: 19, minute: 0)
    
    @Published var mainPath: [Bool] = [false,false,false]
    @Published var path: NavigationPath = NavigationPath()
    
    init() {
        getOnboardingState()
        getUsernameState()
        getWillingToNotifyState()
        getReminderTime()
    }
    
    private func getOnboardingState() {
        guard let state = try UserDefaults.standard.value(forKey: "isOnboardingFinished") else {
            UserDefaults.standard.set(false, forKey: "isOnboardingFinished")
            isOnboardingFinished = false
            return
        }
        
        isOnboardingFinished = state as! Bool
    }
    
    public func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: "isOnboardingFinished")
        isOnboardingFinished = true
    }
    
    public func setUsername(username: String) {
        UserDefaults.standard.set(username, forKey: "username")
        
        DispatchQueue.main.async {
            self.username = username
        }
    }
    
    private func getUsernameState() {
        guard let state = try UserDefaults.standard.value(forKey: "username") else {
            UserDefaults.standard.set("", forKey: "username")
            username = ""
            return
        }
        
        username = state as! String
    }
    
    
    public func setWillingToNotifyState(state: Bool) {
        UserDefaults.standard.set(state, forKey: "willingToNotify")
        willingToNotify = state
    }
    
    public func getWillingToNotifyState() {
        guard let state = try UserDefaults.standard.value(forKey: "willingToNotify") else {
            UserDefaults.standard.set(false, forKey: "willingToNotify")
            willingToNotify = false
            return
        }
        
        willingToNotify = true
    }
    
    public func setReminderTime(breakfastTime: HourAndMinute, lunchTime: HourAndMinute, dinnerTime: HourAndMinute) {
        UserDefaults.standard.storeCodable(breakfastTime, key: "breakfastReminder")
        UserDefaults.standard.storeCodable(lunchTime, key: "lunchReminder")
        UserDefaults.standard.storeCodable(dinnerTime, key: "dinnerReminder")
        
        DispatchQueue.main.async {
            self.breakfastReminder = breakfastTime
            self.lunchReminder = lunchTime
            self.dinnerReminder = dinnerTime
        }
    }
    
    public func getReminderTime() {
        let breakfastData: HourAndMinute? = UserDefaults.standard.retrieveCodable(for: "breakfastReminder")
        if let breakfastData = breakfastData {
            DispatchQueue.main.async {
                self.breakfastReminder = breakfastData
            }
        }
        
        let lunchData: HourAndMinute? = UserDefaults.standard.retrieveCodable(for: "lunchReminder")
        if let lunchData = lunchData {
            DispatchQueue.main.async {
                self.lunchReminder = lunchData
            }
        }
        
        let dinnerData: HourAndMinute? = UserDefaults.standard.retrieveCodable(for: "dinnerReminder")
        if let dinnerData = dinnerData {
            DispatchQueue.main.async {
                self.dinnerReminder = dinnerData
            }
        }
    
        
    }
}
