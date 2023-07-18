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

enum VitachiPhase {
    case morning
    case afternoon
    case evening
    case beforeDayStart
    
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
        }
    }
    
    var defaultMessage: [String] {
        switch self {
        case.beforeDayStart:
            return [VitaDefaultMessage[0], VitaDefaultMessage[1]]
        case.morning:
            return [VitaDefaultMessage[2], VitaDefaultMessage[3]]
        case.afternoon:
            return [VitaDefaultMessage[4], VitaDefaultMessage[5]]
        case.evening:
            return [VitaDefaultMessage[6], VitaDefaultMessage[7]]
        }
    }
    
    var angryMessage: [String] {
        switch self {
        case.beforeDayStart:
            return ["",""]
        case.morning:
            return [VitaAngryMessage[0], VitaAngryMessage[1]]
        case.afternoon:
            return [VitaAngryMessage[2], VitaAngryMessage[3]]
        case.evening:
            return [VitaAngryMessage[4], VitaAngryMessage[5]]
        }
    }
    
    var happyMessage: [String] {
        switch self {
        case.beforeDayStart:
            return ["",""]
        case.morning:
            return [VitaHappyMessage[0], VitaHappyMessage[1]]
        case.afternoon:
            return [VitaHappyMessage[2], VitaHappyMessage[3]]
        case.evening:
            return [VitaHappyMessage[4], VitaHappyMessage[5]]
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
        }
    }
}

let VitaDefaultMessage: [String] = [
    "Don’t forget to eat veggies and fruits or you will constipate!",
    "Take a picture of your meals using the upper right camera icon when mealtime comes 📸",
    "Rise and shine! It's time for you to fill that empty belly. Be sure to eat then take a picture of your meals 📸",
    "I expected you to send me a picture of a healthy meal so that we can eat and be healthy together 🙌",
    "What are you waiting for? Please eat now then add greens and fruits for the best!",
    "I expected you to send me a picture of a healthy meal so that we can eat and be healthy together 🙌",
    "Before the day ends, let’s enjoy a fulfilling, tasty, and healthy meal",
    "I expected you to send me a picture of a healthy meal so that we can eat and be healthy together 🙌"
]

let VitaAngryMessage: [String] = [
    "I did recommend you to start the day with breakfas right? It will be fuel to do the activity!",
    "Please eat your meal and send a picture of it to me so I can ensure you're eating healthy meals 😠",
    "No matter how busy you are, skipping lunch is a bad idea!",
    "Please eat your meal and send a picture of it to me so I can ensure you're eating healthy meals 😠",
    "It’s now or never for dinner! Eating late at night is a no-no for your health",
    "Please eat your meal and send a picture of it to me so I can ensure you're eating healthy meals 😠"
]

let VitaHappyMessage: [String] = [
    "Yum! Feels like I'm having a taste of what you're eating",
    "Well done! Keep up the good work of improving your healthy dietary habits ✊🏻",
    "A healthy lunch a day can keep the doctor away. Good job for not skipping lunch!",
    "Well done! Keep up the good work of improving your healthy dietary habits. ✊🏻",
    "Now, you are ready to wrap up the day after nourishing yourself with meals filled with greens and fruits",
    "Well done! Keep up the good work of improving your healthy dietary habits. ✊🏻"
]


struct VitachiMessageModel {
    let message: String
    let phase: VitachiPhase
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