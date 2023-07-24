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
    
    var message:String {
        switch self {
        case.idle: return "eat your food!"
        case.angry: return "eat your food baka"
        case.happy: return "whos that good boy"
        }
    }
}
struct VitaMoodConfig {
    let widgetBackground : String
    let vitaSpeech : String
//    let
    static func determineConfig(from date: Date, mood: VitaMood) -> VitaMoodConfig {
        let _ = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        return VitaMoodConfig(widgetBackground: mood.image, vitaSpeech: mood.message)
    }
}




