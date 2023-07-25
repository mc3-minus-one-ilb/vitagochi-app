//
//  AppDelegate.swift
//  Vitagochi
//
//  Created by Dzulfikar on 11/07/23.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeDay), name: .NSCalendarDayChanged, object: nil)
        return true
    }
    
    // Selector to handle the NSCalendarDayChanged notification
    @objc func didChangeDay(){
        NotificationHandler.singleton.scheduleAppReminderNotification()
    }
}
