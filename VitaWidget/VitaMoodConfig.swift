//
//  VitaMoodConfig.swift
//  Vitagochi
//
//  Created by Pahala Sihombing on 23/07/23.
//

import SwiftUI

enum VitaMood {
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
    
    var message:String {
        switch self {
        case.idle: return "eat your food!"
        case.angry: return "eat your food baka"
        case.happy: return "whos that good boy"
        }
    }
    
}
struct VitaMoodConfig {
    public static var singleton = VitaMoodConfig()
    var coreData: CoreDataEnvirontment =  CoreDataEnvirontment.singleton
    var mood: VitaMood = .angry
    var phase: VitachiTimePhase = .beforeDayStart
    var challange: ChallangeEntity?
    var mealCompletion: Int = 0
    
    
    init() {
        self.challange = CoreDataEnvirontment.singleton.todayChallange
        
        let now = Date()
        
        if now.isPhaseGreaterThan(.afterDay){
            self.phase = .afterDay
        } else if now.isPhaseGreaterThan(.evening) {
            self.phase = .evening
        } else if now.isPhaseGreaterThan(.afternoon) {
            self.phase = .afternoon
        } else if now.isPhaseGreaterThan(.morning) {
            self.phase = .morning
        } else if now.isPhaseGreaterThan(.beforeDayStart) {
            self.phase = .beforeDayStart
        }
        
        
        self.mealCompletion = challange?.records?.count ?? 0
        
        if let records = challange?.records?.allObjects as? [MealRecordEntity] {
            let isComplete = records.contains{$0.timeStatus == phase.rawValue}
            if Date().isPhaseAfterOneHour(phase) && !isComplete {
                self.mood = .angry
            } else if isComplete {
                self.mood = .happy
            } else {
                self.mood = .idle
            }
        }
        
    }
}




