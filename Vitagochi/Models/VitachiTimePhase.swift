//
//  VitachiModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct HourAndMinute {
    let hour: Int
    let minute: Int
}

struct VitaMessage {
    let text: String
    let soundFile: String
}

enum VitachiTimePhase: Int16 {
    case morning = 0
    case afternoon = 1
    case evening = 2
    case beforeDayStart = 3
    case afterDay = 4
    
    var time: HourAndMinute {
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
    
    var defaultMessage: [VitaMessage] {
        switch self {
        case.beforeDayStart:
            return [VitaDefaultMessage[0], VitaDefaultMessage[1]]
        case.morning:
            return [VitaDefaultMessage[2], VitaDefaultMessage[3]]
        case.afternoon:
            return [VitaDefaultMessage[4], VitaDefaultMessage[5]]
        case.evening:
            return [VitaDefaultMessage[6], VitaDefaultMessage[7]]
        case.afterDay:
            return [VitaDefaultMessage[8]]
        }
    }
    
    var angryMessage: [VitaMessage] {
        switch self {
        case.beforeDayStart:
            return [VitaMessage(text: "", soundFile: "")]
        case.morning:
            return [VitaAngryMessage[0], VitaAngryMessage[1]]
        case.afternoon:
            return [VitaAngryMessage[2], VitaAngryMessage[3]]
        case.evening:
            return [VitaAngryMessage[4], VitaAngryMessage[5]]
        case.afterDay:
            return [VitaMessage(text: "", soundFile: "")]
        }
    }
    
    var happyMessage: [VitaMessage] {
        switch self {
        case.beforeDayStart:
            return [VitaMessage(text: "", soundFile: "")]
        case.morning:
            return [VitaHappyMessage[0], VitaHappyMessage[1]]
        case.afternoon:
            return [VitaHappyMessage[2], VitaHappyMessage[3]]
        case.evening:
            return [VitaHappyMessage[4], VitaHappyMessage[5]]
        case.afterDay:
            return [VitaMessage(text: "", soundFile: "")]
        }
    }
    
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

let VitaDefaultMessage: [VitaMessage] = [
    VitaMessage(text: "Don’t forget to eat veggies and fruits or you will constipate!", soundFile: "beforeDayDefault1"),
    VitaMessage(text: "When it is time to eat, press the camera icon to take a picture of the meal. 📸", soundFile: "beforeDayDefault2"),
    VitaMessage(text: "Rise and shine! It's time for you to fill that empty belly. Be sure to take a picture of your meal before eating it. 📸", soundFile: "morningDefault1"),
    VitaMessage(text: "Vita hopes that you will be able to take pictures of healthy meals. 😋", soundFile: ""),
    VitaMessage(text: "What are you waiting for? Go eat now, make sure to have greens and fruits in it.", soundFile: "afternoonDefault1"),
    VitaMessage(text: "Vita hopes that you will be able to take pictures of healthy meals! 😋", soundFile: ""),
    VitaMessage(text: "Enjoy a full, delicious, and healthy meal before the day is over!", soundFile: "eveningDefault1"),
    VitaMessage(text: "Vita hopes that you will be able to take pictures of healthy meals! 😋", soundFile: ""),
    VitaMessage(text: "Wow, the day went by so fast! I can't wait for the day when we can enjoy another meal together!", soundFile: "afterDayDefault1")
]

let VitaAngryMessage: [VitaMessage] = [
    VitaMessage(text:  "I told you the day starts with breakfast. Otherwise you will be tired during the day. 🤕", soundFile: ""),
    VitaMessage(text:  "To make sure you are eating a healthy diet, please take a picture.", soundFile: "angry1"),
    VitaMessage(text:  "No matter how busy you are. it is not a good idea to skip lunch!", soundFile: "afternoonAngry1"),
    VitaMessage(text:  "To make sure you are eating a healthy diet, please take a picture.", soundFile: "angry1"),
    VitaMessage(text:  "It’s now or never for dinner! Eating late at night is a no-no for your health", soundFile: "eveningAngry1"),
    VitaMessage(text:  "To make sure you are eating a healthy diet, please take a picture.", soundFile: "angry1")
    
]

let VitaHappyMessage: [VitaMessage] = [
    VitaMessage(text:  "Yum! Feels like I'm having a taste of what you're eating", soundFile: "morningHappy1"),
    VitaMessage(text:  "Well done! Keep up the good work of improving your healthy dietary habits ✊🏻", soundFile: "happy1"),
    VitaMessage(text:  "Well done, for not skipping a healthy lunch!", soundFile: "afternoonHappy1"),
    VitaMessage(text: "Well done! Keep up the good work of improving your healthy dietary habits. ✊🏻", soundFile: "happy1"),
    VitaMessage(text:  "Now, you are ready to wrap up the day after nourishing yourself with meals filled with greens and fruits", soundFile: "eveningHappy1"),
    VitaMessage(text:  "Well done! Keep up the good work of improving your healthy dietary habits. ✊🏻", soundFile: "happy1")
    
]


struct VitachiMessageModel {
    let message: String
    let phase: VitachiTimePhase
    let isCompleted: Bool
}

let vitaDummyData: [VitachiMessageModel] = [
    VitachiMessageModel(message: "Rise and shine! It's time for you to fill that empty belly. Be sure to eat then take a picture of your meals 📸", phase: .morning, isCompleted: false),
    VitachiMessageModel(message: "I expected you to send me a picture of a healthy meal so that we can eat and be healthy together 🙌", phase: .morning, isCompleted: false),
    VitachiMessageModel(message: "I did recommend you to start the day with breakfas right? It will be fuel to do the activity!", phase: .morning, isCompleted: false),
    VitachiMessageModel(message: "Please eat your meal and send a picture of it to me so I can ensure you're eating healthy meals 😠", phase: .morning, isCompleted: false),
    VitachiMessageModel(message: "Yum! Feels like I'm having a taste of what you're eating", phase: .morning, isCompleted: true),
    VitachiMessageModel(message: "Well done! Keep up the good work of improving your healthy dietary habits ✊🏻", phase: .morning, isCompleted: true)
]
