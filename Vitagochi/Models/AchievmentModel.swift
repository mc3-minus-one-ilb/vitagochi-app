//
//  AchievmentModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 03/09/23.
//

import SwiftUI

enum AchievementEnum {
    case firstMeal
    case secondOrThirdMeal
    case level2
    case level3
    case levelFinal
    case completed66Days
    
    var title: String {
        switch self {
        case .firstMeal:
            return "Yippee! ✨"
        case .secondOrThirdMeal:
            return "Good Job! 👍"
        case .level2:
            return "Level 2! 🔼"
        case .level3:
            return "Level 3! 🔼"
        case .levelFinal:
            return "Final Form! 🫧"
        case .completed66Days:
            return "Well Done! 👊"
        }
    }
    
    var description: String {
        switch self {
        case .firstMeal:
            return "Today’s first meal will make you\n" +
            "healthier and Vita will become\nprettier!"
        case .secondOrThirdMeal:
            return "So proud of you for putting effort\n" +
            "to eat healthy meal on time. Keep\nthe good work!"
        case .level2, .level3:
            return "Wow ... Vita just unlocked a new\n" +
            "looks and it’s thanks to you. You\n" +
            "are the best! Keep it up!"
        case .levelFinal:
            return "You just unveil Vita true form! She\n" +
            "looks like a goddess right? It’s\nthanks to you!"
        case .completed66Days:
            return "Finally we reach the end of leveling\n" +
            "Vita! In this 66 days you are GOAT!"
        }
    }
    
    var imageName: String  {
        switch self {
        case .firstMeal:
            return "FirstMeal"
        case .secondOrThirdMeal:
            return "SecondOrThirdMeal"
        case .level2:
            return "LevelUp2"
        case .level3:
            return "LevelUp3"
        case .levelFinal:
            return "LevelUpFinal"
        case .completed66Days:
            return "Completed66Days"
        }
    }
}
