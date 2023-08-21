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
    case energizeLunch = 1
    case dinnertimeDelight = 2
    case sunNoonFeast = 3
    case twilightTasting = 4
    case meals3Times = 5
    
    var image: String {
        let type = "Badge"
        switch self {
        case.morningTask:
            return "\(type)MorningTask"
        case.energizeLunch:
            return "\(type)EnergizeLunch"
        case.dinnertimeDelight:
            return "\(type)Dinnertime"
        case.sunNoonFeast:
            return "\(type)SunNoon"
        case.twilightTasting:
            return "\(type)TwilightTasting"
        case.meals3Times:
            return "\(type)3TimesMeals"
        }
    }
    
    var name: String {
        switch self {
        case.morningTask:
            return "Morning Task"
        case.energizeLunch:
            return "Energize Lunch"
        case.dinnertimeDelight:
            return "Dinnertime Delight"
        case.sunNoonFeast:
            return "Sun & Noon Feast"
        case.twilightTasting:
            return "Twlight Tasting"
        case.meals3Times:
            return "3 Times Meals"
        }
    }
    
    var description: String {
        switch self {
        case.morningTask:
            return "Eat Healthy Breakfast\nfor 11 times"
        case.energizeLunch:
            return "Eat Healthy Lunch\nfor 22 times"
        case.dinnertimeDelight:
            return "Eat Healthy Dinner\nfor 22 times"
        case.sunNoonFeast:
            return "Eat Healthy Breakfast & Lunch\nfor 33 times"
        case.twilightTasting:
            return "Eat Healthy Lunch & Dinner\nfor 33 times"
        case.meals3Times:
            return "3x Healthy Meals in a Day\nfor 44 times"
        }
    }
    
    var achievementDescription: String {
        let opening = "Excellent! You've already"
        switch self {
        case.morningTask:
            return "\(opening) eat healthy\nfood for breakfast in 11 days! 👍"
        case.energizeLunch:
            return "\(opening) eat healthy\nfood for lunch in 22 days! 👍"
        case.dinnertimeDelight:
            return "\(opening) eat healthy\nfood for dinner in 22 days! 👍"
        case.sunNoonFeast:
            return "\(opening) eat healthy\nfood for breakfast & lunch in 33 days! 👍"
        case.twilightTasting:
            return "\(opening) eat healthy\nfood lunch & dinner in 33 days! 👍"
        case.meals3Times:
            return "\(opening) eat 3x healthy\nfood in a Day for 44 days! 👍"
        }
    }
    
    func checkIsItAchieved(challanges: [ChallangeEntity], phase: VitaTimePhase) -> Bool {
        switch phase {
        case.beforeDayStart, .afterDay: return false
        case.morning:
            return checkBadgesForMorning(challanges: challanges)
        case.afternoon:
            return checkBadgesForAfternoon(challanges: challanges)
        case.evening:
            return checkBadgesForEvening(challanges: challanges)
        }
    }
    
    private func checkBadgesForMorning(challanges: [ChallangeEntity]) -> Bool {
        switch self {
        case.morningTask:
            let breakfast = challanges.filter { challange in
                if let records = challange.records?.allObjects as? [MealRecordEntity] {
                    if records.isEmpty {return false}
                    return records.contains { record in
                        record.mealStatus == 0
                    }
                }
                return false
            }.count
            return breakfast >= 11
        
        default:
            return false
        }
    }
    
    private func checkBadgesForAfternoon(challanges: [ChallangeEntity]) -> Bool {
        switch self {
        case.energizeLunch:
            let lunch = challanges.filter { challange in
                if let records = challange.records?.allObjects as? [MealRecordEntity] {
                    if records.isEmpty {return false}
                    return records.contains { record in
                        record.mealStatus == 1
                    }
                }
                return false
            }.count
            return lunch >= 22
        case.sunNoonFeast:
            let fastLunch = challanges.filter { challange in
                if let records = challange.records?.allObjects as? [MealRecordEntity] {
                    if records.count <= 1 {return false}
                    return records.contains { record in
                        record.mealStatus == 0
                    } && records.contains { record in
                        record.mealStatus == 1
                    }
                }
                return false
            }.count
            return fastLunch >= 33
        default: return false
        }
    }
    
    private func checkBadgesForEvening(challanges: [ChallangeEntity]) -> Bool {
        switch self {
        case.dinnertimeDelight:
            let dinner = challanges.filter { challange in
                if let records = challange.records?.allObjects as? [MealRecordEntity] {
                    if records.isEmpty {return false}
                    return records.contains { record in
                        record.mealStatus == 2
                    }
                }
                return false
            }.count
            return dinner >= 22
        case.twilightTasting:
            let lunchDinner = challanges.filter { challange in
                if let records = challange.records?.allObjects as? [MealRecordEntity] {
                    if records.count <= 1 {return false}
                    return records.contains { record in
                        record.mealStatus == 1
                    } && records.contains { record in
                        record.mealStatus == 2
                    }
                }
                return false
            }.count
            return lunchDinner >= 33
        case.meals3Times:
            let meals3 = challanges.filter { challange in
                if let records = challange.records?.allObjects as? [MealRecordEntity] {
                    return records.count >= 3
                }
                return false
            }.count
            return meals3 >= 44
        default: return false
        }
    }
}
