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
            return HourAndMinute(hour: 17, minute: 0)
        case.afterDay:
            return HourAndMinute(hour: 21, minute: 0)
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
            return "Rise and dine, it’s a perfect act \nto start the day with healthy \nfood!"
        case.afternoon:
            return "Here we go! Noontime feast! \nIt's a midday delight in hectic \ntimes"
        case.evening:
            return "A delicious finale, perfect way \nto end today’s journey!"
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

let vitaFirstTimeAppMessage = VitaMessage(text: "Welcome! I'm Vita, " +
                                  "i'm here to support your healthy eating. " +
                                  "Tap me to speak to you.",
                                  soundFileName: "welcome")

let vitaTapDefaultMessage = VitaMessage(text: "Vita hopes that you will be able " +
                                        "to take pictures of healthy meals. 😋",
                                        soundFileName: "default1")

let vitaDefaultMessage: [VitaMessage] = [
    VitaMessage(text: "Don’t forget to eat veggies " +
                "and fruits or you will constipate!",
                soundFileName: "beforeDayDefault1"),
    VitaMessage(text: "When it is time to eat, press the " +
                "camera icon to take a picture of the meal. 📸",
                soundFileName: "beforeDayDefault2"),
    VitaMessage(text: "Rise and shine! It's time for you to " +
                "fill that empty belly. Be sure to take " +
                "a picture of your meal before eating it. 📸",
                soundFileName: "morningDefault1"),
    VitaMessage(text: "What are you waiting for? Go eat now, " +
                "make sure to have greens and fruits in it.",
                soundFileName: "afternoonDefault1"),
    VitaMessage(text: "Enjoy a full, delicious, " +
                "and healthy meal before the day is over!",
                soundFileName: "eveningDefault1"),
    VitaMessage(text: "Wow, the day went by so fast! I can't wait " +
                "for the day when we can enjoy another meal together!",
                soundFileName: "afterDayDefault1")
]

let vitaTapAngryMessage =  VitaMessage(text: "To make sure you are eating a healthy diet, " +
                                       "please take a picture.",
                                       soundFileName: "angry1")

let vitaAngryMessage: [VitaMessage] = [
    VitaMessage(text: "I told you the day starts with breakfast. " +
                "Otherwise you will be tired during the day. 🤕",
                soundFileName: "morningAngry1"),
    VitaMessage(text: "No matter how busy you are. it is not " +
                "a good idea to skip lunch!",
                soundFileName: "afternoonAngry1"),
    VitaMessage(text: "It’s now or never for dinner! " +
                "Eating late at night is a no-no for your health",
                soundFileName: "eveningAngry1")
]

let vitaTapHappyMessage = VitaMessage(text: "Well done! Keep up the good work " +
            "of improving your healthy dietary habits ✊🏻",
            soundFileName: "happy1")

let vitaHappyMessage: [VitaMessage] = [
    VitaMessage(text: "Yum! Feels like I'm having " +
                "a taste of what you're eating",
                soundFileName: "morningHappy1"),
    VitaMessage(text: "Well done, for not skipping a healthy lunch!",
                soundFileName: "afternoonHappy1"),
    VitaMessage(text: "Now, you are ready to wrap up the day after " +
                "nourishing yourself with meals filled with greens and fruits",
                soundFileName: "eveningHappy1")
]

let vitaSickMessage: [VitaMessage] = [
    VitaMessage(text: "Yesterday, you didn’t eat any healthy meals, " +
                "that’s why my condition become like this 😭",
                soundFileName: "sickDefault1"),
    VitaMessage(text: "For today, please eat healthy food! " +
                "It will be good for you and me 🥺",
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
