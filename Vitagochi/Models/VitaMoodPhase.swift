//
//  VitachiMoodPhase.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI

enum VitaMoodPhase {
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
    
    func getMessage(vitaPhase: VitaTimePhase, isTapped: Bool, isAfterSick: Bool = false) -> VitaMessage {
        switch self {
        case.idle:
            return vitaPhase.defaultMessage[isTapped ? 1 : 0]
        case.happy:
            var vitaMessage: VitaMessage
            
            if isAfterSick {
                vitaMessage = isTapped ? vitaPhase.happyMessage[1] : vitaSickMessage[2]
            } else {
                vitaMessage = vitaPhase.happyMessage[isTapped ? 1 : 0]
            }
            
            return vitaMessage
        case.angry:
            return vitaPhase.angryMessage[isTapped ? 1 : 0]
        case.sick:
            return vitaSickMessage[isTapped ? 1 : 0]
        }
    }
}
