//
//  BadgesEnum.swift
//  Vitagochi
//
//  Created by Enzu Ao on 26/07/23.
//

import SwiftUI

struct BadgeModel: Identifiable {
    var id: String = UUID().uuidString
    var type: BadgeType
}

enum BadgeType: Int16, CaseIterable {
    case morningTask = 0
    case happyLunch = 1
    case delightDinner = 2
    case doubleFeast = 3
    case twilightTaste = 4
    case tripleMeals = 5
    
    var image: String {
        let type = "Badge"
        switch self {
        case.morningTask:
            return "\(type)MorningTask"
        case.happyLunch:
            return "\(type)HappyLunch"
        case.delightDinner:
            return "\(type)DelightDinner"
        case.doubleFeast:
            return "\(type)DoubleFeast"
        case.twilightTaste:
            return "\(type)TwilightTaste"
        case.tripleMeals:
            return "\(type)TripleMeals"
        }
    }
    
    var name: String {
        switch self {
        case.morningTask:
            return "Morning Task"
        case.happyLunch:
            return "Happy Lunch"
        case.delightDinner:
            return "Delight Dinner"
        case.doubleFeast:
            return "Double Feast"
        case.twilightTaste:
            return "Twilight Taste"
        case.tripleMeals:
            return "Triple Meals"
        }
    }
    
    var description: String {
        let daysToAchiveBadge = self.daysToAchiveBadge
        switch self {
        case.morningTask:
            return "Eat Healthy Breakfast\nfor \(daysToAchiveBadge) times"
        case.happyLunch:
            return "Eat Healthy Lunch\nfor \(daysToAchiveBadge) times"
        case.delightDinner:
            return "Eat Healthy Dinner\nfor \(daysToAchiveBadge) times"
        case.doubleFeast:
            return "Eat Healthy Breakfast\n& Lunch for \(daysToAchiveBadge) times"
        case.twilightTaste:
            return "Eat Healthy Lunch\n& Dinner for \(daysToAchiveBadge) times"
        case.tripleMeals:
            return "Eat Healthy Meals\n3x Day for \(daysToAchiveBadge) times"
        }
    }
    
    var daysToAchiveBadge: Int {
        switch self  {
        case.morningTask:
            return 11
        case.happyLunch:
            return 22
        case.delightDinner:
            return 22
        case.doubleFeast:
            return 33
        case.twilightTaste:
            return 33
        case.tripleMeals:
            return 44
        }
    }
    
    var achievementDescription: String {
        let opening = "badges is\ngrant to you after you eat a healthy\nmeal for "
        var description = ""
        let daysToAchiveBadge = self.daysToAchiveBadge
        
        switch self {
        case.morningTask:
            description = "breakfast in \(daysToAchiveBadge) days"
        case.happyLunch:
            description = "lunch in \(daysToAchiveBadge) days"
        case.delightDinner:
            description = "dinner in \(daysToAchiveBadge) days"
        case.doubleFeast:
            description = "breakfast & lunch in \(daysToAchiveBadge)\ndays"
        case.twilightTaste:
            description = "lunch & dinner in \(daysToAchiveBadge)\ndays"
        case.tripleMeals:
            return "badges is grant\nto you after you eat a healthy meal\n" +
            "3x a Day for \(daysToAchiveBadge) days"
        }
        return opening + description
    }
}
