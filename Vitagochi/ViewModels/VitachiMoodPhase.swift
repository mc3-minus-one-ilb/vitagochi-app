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
}

