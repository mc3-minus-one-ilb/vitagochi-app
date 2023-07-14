//
//  GlobalEnvirontment.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import Foundation
class GlobalEnvirontment: ObservableObject {
    static var singleton = GlobalEnvirontment()
    
    @Published var username: String = ""
    @Published var isOnboardingFinished: Bool = false
    @Published var willingToNotify: Bool = false
    
    init() {
        getOnboardingState()
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
    
    private func getUsernameState() {
        guard let state = try UserDefaults.standard.value(forKey: "username") else {
            UserDefaults.standard.set("", forKey: "username")
            username = ""
            return
        }
        
        username = ""
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
}
