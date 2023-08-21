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
        switch self {
        case.casual:
            return "Pink"
        case.orange:
            return "Oren"
        case.green:
            return "Green"
        case.white:
            return "White"
        }
    }
    
    func maxFrame(mood: VitaMoodPhase) -> Int {
        switch self {
        case.casual:
            return casualMaxFrame(mood: mood)
        case.orange:
            return orangeMaxFrame(mood: mood)
        case.green:
            return greenMaxFrame(mood: mood)
        case.white:
            return whiteMaxFrame(mood: mood)
        }
    }
    
    private func casualMaxFrame(mood: VitaMoodPhase) -> Int {
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
    }
    
    private func orangeMaxFrame(mood: VitaMoodPhase) -> Int {
        switch mood {
        case.idle:
            return 16
        case.happy:
            return 19
        case.angry:
            return 16
        case.sick:
            return 18
        }
    }
    
    private func greenMaxFrame(mood: VitaMoodPhase) -> Int {
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
    }
    
    private func whiteMaxFrame(mood: VitaMoodPhase) -> Int {
        switch mood {
        case.idle:
            return 16
        case.happy:
            return 19
        case.angry:
            return 16
        case.sick:
            return 18
        }
    }
}
