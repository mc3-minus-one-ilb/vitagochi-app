//
//  NotificationHandler.swift
//  Vitagochi
//
//  Created by Dzulfikar on 24/07/23.
//

import Foundation
import UserNotifications

class NotificationHandler {
    static let singleton = NotificationHandler()
    private let globalEnv: GlobalEnvirontment = GlobalEnvirontment.singleton
    
    func registerNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { _, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func scheduleReminderNotification(hourMinute: HourAndMinute, type: ReminderType) {
        let center = UNUserNotificationCenter.current()
        
        // recurring date is everyday
        var dateComponents = DateComponents()
        
        dateComponents.hour = hourMinute.hour
        dateComponents.minute = hourMinute.minute
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: type.getString(), content: type.getNotificationContent(), trigger: trigger)
        center.add(request) { error in
            if let error = error {
                print("Error: \(error)")
            }
            
            print(
                """
                Notification scheduled for \(type.getString()) at \(hourMinute.hour):\(hourMinute.minute)
                """
            )
        }
    }
    
    func removeNotificationById(
        identifier: String
    ) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
    
    func showScheduledNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { notifications in
            for notification in notifications {
                print(notification)
            }
        }
    }
    
    func scheduleAppReminderNotification() {
        scheduleReminderNotification(hourMinute: globalEnv.breakfastReminder, type: ReminderType.BREAKFAST)
        scheduleReminderNotification(hourMinute: HourAndMinute(hour: globalEnv.breakfastReminder.hour + 1, minute: globalEnv.breakfastReminder.minute), type: ReminderType.BREAKFAST_NOT_YET)
        
        scheduleReminderNotification(hourMinute: globalEnv.lunchReminder, type: ReminderType.LUNCH)
        scheduleReminderNotification(hourMinute: HourAndMinute(hour: globalEnv.lunchReminder.hour + 1, minute: globalEnv.lunchReminder.minute), type: ReminderType.LUNCH_NOT_YET)
        
        scheduleReminderNotification(hourMinute: globalEnv.dinnerReminder, type: ReminderType.DINNER)
        scheduleReminderNotification(hourMinute: HourAndMinute(hour: globalEnv.dinnerReminder.hour + 1, minute: globalEnv.dinnerReminder.minute), type: ReminderType.DINNER_NOT_YET)
        
    }
}
