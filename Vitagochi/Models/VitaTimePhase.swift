//
//  VitachiModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct HourAndMinute: Codable, Equatable {
    let hour: Int
    let minute: Int
}

struct VitaMessage: Equatable {
    let text: String
    let soundFileName: String
}

// TODO: Change Copy Writing

enum VitaTimePhase: Int16, CaseIterable {
    case morning = 0
    case afternoon = 1
    case evening = 2
    case beforeDayStart = 3
    case afterDay = 4
    
    var time: HourAndMinute {
//        let envObj: GlobalEnvirontment = GlobalEnvirontment.singleton
        switch self {
        case.beforeDayStart:
            return HourAndMinute(hour: 0, minute: 0)
        case.morning:
            return HourAndMinute(hour: 7, minute: 0)
        case.afternoon:
            return HourAndMinute(hour: 12, minute: 0)
        case.evening:
            return HourAndMinute(hour: 18, minute: 0)
        case.afterDay:
            return HourAndMinute(hour: 23, minute: 0)
        }
    }
    
    var mealTime: String {
        switch self {
        case .beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "Breakfast"
        case.afternoon:
            return "Lunch"
        case.evening:
            return "Dinner"
        }
    }
    
    var mealTimeIcon: String {
        switch self {
        case .beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "☀️🍽️"
        case.afternoon:
            return "🌤️🍽️"
        case.evening:
            return "🌙🍽️"
        }
    }
    
    var mealBackground: String {
        switch self {
        case .beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "CardBreakfastBackground"
        case.afternoon:
            return "CardLunchBackground"
        case.evening:
            return "CardDinnerBackground"
        }
    }
    
    var mealQuote: String {
        switch self {
        case .beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "Breakfast is a perfect way\nto start the day"
        case.afternoon:
            return "Lunch is a delight moment\nin the middle of the day"
        case.evening:
            return "Dinner is a perfect finale\nthroughout the day"
        }
    }
    
    var nextPhase: VitaTimePhase {
        switch self {
        case.beforeDayStart:
            return .morning
        case.morning:
            return .afternoon
        case.afternoon:
            return .evening
        case.evening:
            return .afterDay
        case.afterDay:
            return .beforeDayStart
        }
    }
    
    var defaultMessage: [VitaMessage] {
        switch self {
        case.beforeDayStart:
            return [vitaDefaultMessage[0], vitaDefaultMessage[1]]
        case.morning:
            return [vitaDefaultMessage[2], vitaTapDefaultMessage]
        case.afternoon:
            return [vitaDefaultMessage[3], vitaTapDefaultMessage]
        case.evening:
            return [vitaDefaultMessage[4], vitaTapDefaultMessage]
        case.afterDay:
            return [vitaDefaultMessage[5], vitaDefaultMessage[0]]
        }
    }
    
    var angryMessage: [VitaMessage] {
        switch self {
        case.beforeDayStart, .afterDay:
            return [VitaMessage(text: "", soundFileName: "")]
        case.morning:
            return [vitaAngryMessage[0], vitaTapAngryMessage]
        case.afternoon:
            return [vitaAngryMessage[1], vitaTapAngryMessage]
        case.evening:
            return [vitaAngryMessage[2], vitaTapAngryMessage]
        }
    }
    
    var happyMessage: [VitaMessage] {
        switch self {
        case.beforeDayStart, .afterDay:
            return [VitaMessage(text: "", soundFileName: "")]
        case.morning:
            return [vitaHappyMessage[0], vitaTapHappyMessage]
        case.afternoon:
            return [vitaHappyMessage[1], vitaTapHappyMessage]
        case.evening:
            return [vitaHappyMessage[2], vitaTapHappyMessage]
        }
    }
    
    var icon: String {
        switch self {
        case.beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "sun.max.fill"
        case.afternoon:
            return "cloud.sun.fill"
        case.evening:
            return "moon.stars.fill"
        }
    }
//
    var completedIndex: Int {
        switch self {
        case.beforeDayStart:
            return 0
        case.morning:
            return 1
        case.afternoon:
            return 2
        case.evening:
            return 3
        case.afterDay:
            return 4
        }
    }
    
    
}


let vitaFirstTimeAppMessage = VitaMessage(text: "Vita is here to remind " +
                                  "you to eat healthy meals 3x a day!",
                                  soundFileName: "welcome")

let vitaTapDefaultMessage = VitaMessage(text: "Vita hopes you will take  " +
                                        "a pictures of your healthy meals!",
                                        soundFileName: "default1")

let vitaDefaultMessage: [VitaMessage] = [
    VitaMessage(text: "Make sure you put veggies and fruits " +
                "on your meals!",
                soundFileName: "beforeDayDefault1"),
    VitaMessage(text: "Take a picture of your healthy meals " +
                "when it's time to eat!",
                soundFileName: "beforeDayDefault2"),
    VitaMessage(text: "Rise and dine! It's a breakfast time! " +
                "Can Vita see your meal?",
                soundFileName: "morningDefault1"),
    VitaMessage(text: "What are you waiting for? " +
                "Let's have a lunch with Vita",
                soundFileName: "afternoonDefault1"),
    VitaMessage(text: "Let's enjoy a healthy dinner " +
                "before the day is over",
                soundFileName: "eveningDefault1"),
    VitaMessage(text: "Wow, the day flew by! " +
                "Vita excited to see your next meal",
                soundFileName: "afterDayDefault1")
]

let vitaTapAngryMessage =  VitaMessage(text: "It's a piece of cake to take " +
                                       "a picture of healthy meals",
                                       soundFileName: "angry1")

let vitaAngryMessage: [VitaMessage] = [
    VitaMessage(text: "Have a breakfast first. If you skip it, " +
                "you will regret it!",
                soundFileName: "morningAngry1"),
    VitaMessage(text: "It's not a good idea to skip lunch " +
                "even though you're busy",
                soundFileName: "afternoonAngry1"),
    VitaMessage(text: "Dinner is now or never! " +
                "Don't you dare to eat in a late of night",
                soundFileName: "eveningAngry1")
]

let vitaTapHappyMessage = VitaMessage(text: "Keep up the good work to " +
            "improve your healthy dietary!",
            soundFileName: "happy1")

let vitaHappyMessage: [VitaMessage] = [
    VitaMessage(text: "Yum! Vita can taste " +
                "of what you're eating",
                soundFileName: "morningHappy1"),
    VitaMessage(text: "Well done, for not skipping a healthy lunch!",
                soundFileName: "afternoonHappy1"),
    VitaMessage(text: "Yeay! After eating a healthy meal, " +
                "let's wrap up this day",
                soundFileName: "eveningHappy1")
]

let vitaSickMessage: [VitaMessage] = [
    VitaMessage(text: "Yesterday you didn’t eat any healthy meals! " +
                "Soon you will become like this",
                soundFileName: "sickDefault1"),
    VitaMessage(text: "For today, please eat healthy food.. ",
                soundFileName: "sickDefault2"),
    VitaMessage(text: "As expected from healthy food! " +
                "Let’s keep the pace like this!",
                soundFileName: "sickAfter1")
]

// struct VitachiMessageModel {
//    let message: String
//    let phase: VitaTimePhase
//    let isCompleted: Bool
// }
//
// let vitaDummyData: [VitachiMessageModel] = [
//    VitachiMessageModel(message: "Rise and shine! It's time for you to fill that empty belly. Be sure to eat then take a picture of your meals 📸", phase: .morning, isCompleted: false),
//    VitachiMessageModel(message: "I expected you to send me a picture of a healthy meal so that we can eat and be healthy together 🙌", phase: .morning, isCompleted: false),
//    VitachiMessageModel(message: "I did recommend you to start the day with breakfas right? It will be fuel to do the activity!", phase: .morning, isCompleted: false),
//    VitachiMessageModel(message: "Please eat your meal and send a picture of it to me so I can ensure you're eating healthy meals 😠", phase: .morning, isCompleted: false),
//    VitachiMessageModel(message: "Yum! Feels like I'm having a taste of what you're eating", phase: .morning, isCompleted: true),
//    VitachiMessageModel(message: "Well done! Keep up the good work of improving your healthy dietary habits ✊🏻", phase: .morning, isCompleted: true)
// ]
