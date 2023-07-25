//
//  ReminderType.swift
//  Vitagochi
//
//  Created by Dzulfikar on 24/07/23.
//

import Foundation
import UserNotifications

enum ReminderType {
    case BREAKFAST
    case BREAKFAST_NOT_YET
    case LUNCH
    case LUNCH_NOT_YET
    case DINNER
    case DINNER_NOT_YET
}

extension ReminderType {
    func getNotificationContent() -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        switch self {
        case .BREAKFAST:
            notificationContent.title = "Have you eaten?"
            notificationContent.body = "Let's eat together so we can have more energy! 🥞"
        case .BREAKFAST_NOT_YET:
            notificationContent.title = "Did you forget to breakfast?"
            notificationContent.body = "You should have breakfast as it offers many benefits 😉"
        case .LUNCH:
            notificationContent.title = "Let’s eat lunch with me!"
            notificationContent.body = "It’s a perfect time to eat full meals 🍽️"
        case .LUNCH_NOT_YET:
            notificationContent.title = "Are you gonna skipping lunch?"
            notificationContent.body = "Eating lunch is a simple task, so please do it 🥺"
        case .DINNER:
            notificationContent.title = "It’s dinner time!"
            notificationContent.body = "After a long day, treat yourself to the best dinner 🍲"
        case .DINNER_NOT_YET:
            notificationContent.title = "Oh no! You better eat now!"
            notificationContent.body = "Eating too late at night is not good for health 😮‍💨"
        default:
            break
        }
        return notificationContent
    }
    
    func getString() -> String {
        switch self {
        case .BREAKFAST:
            return "breakfast"
        case .BREAKFAST_NOT_YET:
            return "breakfast_not_yet"
        case .LUNCH:
            return "lunch"
        case .LUNCH_NOT_YET:
            return "lunch_not_yet"
        case .DINNER:
            return "dinner"
        case .DINNER_NOT_YET:
            return "dinner_not_yet"
        default:
            return ""
        }
    }
}
