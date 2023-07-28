//
//  VitachiMoodPhase.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI

enum VitachiMoodPhase {
    case idle
    case happy
    case angry
    case sick
    
    var image: String {
        switch self {
        case.idle:
            return "MainVitaIdle"
        case.happy:
            return "MainVitaHappy"
        case.angry:
            return "MainVitaAngry"
        case.sick:
            return "MainVitaSick"
        }
    }
    
    var skin: String {
        switch self {
        case.idle:
            return "Def"
        case.happy:
            return "Hap"
        case.angry:
            return "Ang"
        case.sick:
            return "Acne"
        }
    }
}

let VitaSickMessage: [VitaMessage] = [
    VitaMessage(text: "Yesterday, you didn’t eat any healthy meals, that’s why my condition become like this 😭", soundFile: "sickDefault1"),
    VitaMessage(text: "For today, please eat healthy food! It will be good for you and me 🥺", soundFile: "sickDefault2"),
    VitaMessage(text: "As expected from healthy food! Let’s keep the pace like this!", soundFile: "sickAfter1")
    
]

