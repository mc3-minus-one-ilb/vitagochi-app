//
//  ReminderType.swift
//  Vitagochi
//
//  Created by Dzulfikar on 24/07/23.
//

import Foundation
import UserNotifications

enum ReminderType {
    case breakfast
    case breakfastNotYet
    case lunch
    case lunchNotYet
    case dinner
    case dinnerNotYet
}

extension ReminderType {
    func getNotificationContent() -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        switch self {
        case .breakfast:
            notificationContent.title = "Have you eaten?"
            notificationContent.body = "Let's eat together so we can have more energy! 🥞"
        case .breakfastNotYet:
            notificationContent.title = "Did you forget to breakfast?"
            notificationContent.body = "You should have breakfast as it offers many benefits 😉"
        case .lunch:
            notificationContent.title = "Let’s eat lunch with me!"
            notificationContent.body = "It’s a perfect time to eat full meals 🍽️"
        case .lunchNotYet:
            notificationContent.title = "Are you gonna skipping lunch?"
            notificationContent.body = "Eating lunch is a simple task, so please do it 🥺"
        case .dinner:
            notificationContent.title = "It’s dinner time!"
            notificationContent.body = "After a long day, treat yourself to the best dinner 🍲"
        case .dinnerNotYet:
            notificationContent.title = "Oh no! You better eat now!"
            notificationContent.body = "Eating too late at night is not good for health 😮‍💨"
        }
        return notificationContent
    }
    
    func getString() -> String {
        switch self {
        case .breakfast:
            return "breakfast"
        case .breakfastNotYet:
            return "breakfast_not_yet"
        case .lunch:
            return "lunch"
        case .lunchNotYet:
            return "lunch_not_yet"
        case .dinner:
            return "dinner"
        case .dinnerNotYet:
            return "dinner_not_yet"
        }
    }
}
