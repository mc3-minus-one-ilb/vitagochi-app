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
        let request = UNNotificationRequest(identifier: type.getString(),
                                            content: type.getNotificationContent(),
                                            trigger: trigger)
        center.add(request) { error in
            if let error = error {
                print("Error: \(error)")
            }
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
        let breakfastHourMinute = HourAndMinute(hour: globalEnv.breakfastReminder.hour + 1,
                                                minute: globalEnv.breakfastReminder.minute)
        let lunchHourMinute = HourAndMinute(hour: globalEnv.lunchReminder.hour + 1,
                                            minute: globalEnv.lunchReminder.minute)
        let dinnerHourMinute = HourAndMinute(hour: globalEnv.dinnerReminder.hour + 1,
                                             minute: globalEnv.dinnerReminder.minute)
        
        scheduleReminderNotification(hourMinute: globalEnv.breakfastReminder,
                                     type: ReminderType.breakfast)
        scheduleReminderNotification(hourMinute: breakfastHourMinute,
                                     type: ReminderType.breakfastNotYet)
        
        scheduleReminderNotification(hourMinute: globalEnv.lunchReminder,
                                     type: ReminderType.lunch)
        scheduleReminderNotification(hourMinute: lunchHourMinute, type:
                                        ReminderType.lunchNotYet)
        
        scheduleReminderNotification(hourMinute: globalEnv.dinnerReminder,
                                     type: ReminderType.dinner)
        scheduleReminderNotification(hourMinute: dinnerHourMinute,
                                     type: ReminderType.dinnerNotYet)
        
    }
    
    func removeNotificationNotYet(timePhase: VitaTimePhase) {
        switch timePhase {
        case .morning:
            removeNotificationById(
                identifier: ReminderType.breakfastNotYet.getString())
        case .afternoon:
            removeNotificationById(
                identifier: ReminderType.lunchNotYet.getString())
        case .evening:
            removeNotificationById(
                identifier: ReminderType.dinnerNotYet.getString())
        case .beforeDayStart, .afterDay: break
        }
    }
}
