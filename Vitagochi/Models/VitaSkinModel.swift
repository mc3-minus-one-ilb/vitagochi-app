//
//  VitaModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

enum VitaSkinModel: Int {
    case casual = 0
    case orange = 1
    case green = 2
    case white = 3
    
    var skin: String {
        switch self{
        case.casual:
            return "Pink"
        case.orange:
            return "Orange"
        case.green:
            return "Green"
        case.white:
            return "White"
        }
    }
    
    func maxFrame(mood: VitachiMoodPhase)-> Int {
        switch self {
        case.casual:
            switch mood {
            case.idle:
                return 16
            case.happy:
                return 20
            case.angry:
                return 16
            case.sick:
                return 18
            }
        default:
            return 0
        }
    }
}
