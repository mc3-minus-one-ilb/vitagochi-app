//
//  VitaMoodConfig.swift
//  Vitagochi
//
//  Created by Pahala Sihombing on 23/07/23.
//

import SwiftUI

enum VitaWidgetTimePhase: Int16, CaseIterable {
    case morning = 0
    case afternoon = 1
    case evening = 2
    case beforeDayStart = 3
    case afterDay = 4
    
    var time: HourAndMinute {
        let envObj: GlobalEnvirontment = GlobalEnvirontment.singleton
        switch self {
        case.beforeDayStart:
            return HourAndMinute(hour: 0, minute: 0)
        case.morning:
            return envObj.breakfastReminder
        case.afternoon:
            return envObj.lunchReminder
        case.evening:
            return envObj.dinnerReminder
        case.afterDay:
            return HourAndMinute(hour: 21, minute: 0)
        }
    }
    
    var mealTimeIcon: String {
        switch self {
        case .beforeDayStart, .afterDay:
            return "🍽️"
        case.morning:
            return "☀️🍽️"
        case.afternoon:
            return "🌤️🍽️"
        case.evening:
            return "🌙🍽️"
        }
    }
    
    var titleIdleText: String {
        switch self {
        case.beforeDayStart:
            return "It's a New Day!"
        case.morning:
            return "Breakfast Time!"
        case.afternoon:
            return "Lunch Time!"
        case.evening:
            return "Dinner Time!"
        case.afterDay:
            return ""
        }
    }
}

enum VitaWidgetMood {
    case idle
    case angry
    case happy
    
    var image: String {
        switch self {
        case.idle: return "SWDefault"
        case.happy: return "SWHappy"
        case.angry: return "SWAngry"
        }
    }
    
    var imageMedium: String {
        switch self {
        case.idle: return "MWDefault"
        case.happy: return "MWHappy"
        case.angry: return "MWAngry"
        }
    }
    
    var message: String {
        switch self {
        case.idle: return "eat your food!"
        case.angry: return "eat your food baka"
        case.happy: return "whos that good boy"
        }
    }
    
    func mediumMessage(phase: VitaWidgetTimePhase) -> String {
        switch self {
        case.idle:
            return mediumIdleMessage(phase: phase)
        case.angry:
            return mediumAngryMessage(phase: phase)
        case.happy:
            return mediumHappyMessage(phase: phase)
        }
    }
    
    private func mediumIdleMessage(phase: VitaWidgetTimePhase) -> String {
        switch phase {
        case.beforeDayStart:
            return "Let’s eat together when the times comes!✊🏻"
        case.morning:
            return "Rise and shine! Time for you to have breakfast☀️"
        case.afternoon:
            return "It’s noontime feast! Let’s have lunch!🌤️"
        case.evening:
            return "Finally! End this day with healthy dinner!🌙✨"
        case.afterDay:
            return ""
        }
    }
    
    private func mediumAngryMessage(phase: VitaWidgetTimePhase) -> String {
        switch phase {
        case.beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "Knock knock! Please eat, so you can be energize!"
        case.afternoon:
            return "Let’s have lunch first, then you can continue your day!"
        case.evening:
            return "Don’t you feel hungry after this long day?"
        }
    }
    
    private func mediumHappyMessage(phase: VitaWidgetTimePhase) -> String {
        switch phase {
        case.beforeDayStart, .afterDay:
            return ""
        case.morning:
            return "Yeay! You are ready to ride this day!🥰"
        case.afternoon:
            return "Yumm! That’s such a healthy and fulfilling meals🥰"
        case.evening:
            return "I’m so full! Looking forward for tomorrow meals🥰"
        }
    }
}

// struct VitaMoodConfig {
//    public static var singleton = VitaMoodConfig()
//    var coreData: CoreDataEnvirontment =  CoreDataEnvirontment.singleton
//    var mood: VitaMood = .angry
//    var phase: VitachiWidgetTimePhase = .beforeDayStart
//    var challange: ChallangeEntity?
//    var mealCompletion: Int = 0
//
//
//    init() {
//        self.challange = CoreDataEnvirontment.singleton.todayChallange
//
//        let now = Date()
//
//        if now.isWidgetPhaseGreaterThan(.afterDay){
//            self.phase = .afterDay
//        } else if now.isWidgetPhaseGreaterThan(.evening) {
//            self.phase = .evening
//        } else if now.isWidgetPhaseGreaterThan(.afternoon) {
//            self.phase = .afternoon
//        } else if now.isWidgetPhaseGreaterThan(.morning) {
//            self.phase = .morning
//        } else if now.isWidgetPhaseGreaterThan(.beforeDayStart) {
//            self.phase = .beforeDayStart
//        }
//
//
//        self.mealCompletion = challange?.records?.count ?? 0
//
//        if let records = challange?.records?.allObjects as? [MealRecordEntity] {
//            let isComplete = records.contains{$0.timeStatus == phase.rawValue}
//            if Date().isWidgetPhaseAfterOneHour(phase) && !isComplete {
//                self.mood = .angry
//            } else if isComplete {
//                self.mood = .happy
//            } else {
//                self.mood = .idle
//            }
//        }
//
//    }
// }
