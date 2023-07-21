//
//  Message.swift
//  Vitagochi
//
//  Created by Enzu Ao on 19/07/23.
//

import Foundation

struct Message: Identifiable, Equatable {
    var id: Date
    var text: String
    var isMyMessage: Bool
    var profilPic: String
    var photo: Data?
    var vitaAnswer: VitaMessageAnswer?
}

enum VitaMessageAnswer: Int16, CaseIterable {
    case exactly = 0
    case greensOnly = 1
    case fruitsOnly = 2
    case sadlyNo = 3
    
    var answer: String {
        switch self {
        case.exactly:
            return "Excelent! Way to go, your fruit and veggie virtouso. Congratulation on take a lil step of embracing a healthy dietary habit 🎉"
        case.greensOnly:
            return "It's okay, take your time! I know fruits, but consider to eat it later, okay? 😉"
        case.fruitsOnly:
            return "Yumm... fruits always be tasty but believe greens can be tasty too! Sot eat it later okay? 😉"
        case.sadlyNo:
            return "Huft... haris can be disappointing at times, Just promise me you'll munch on greens and fruits next time, alright ? 😔"
        }
    }
    
    var myAnswer: String {
        switch self {
        case.exactly:
            return "Exactly! ☺️"
        case.greensOnly:
            return "It's just greens 😐"
        case.fruitsOnly:
            return "Only Fruits 🙃"
        case.sadlyNo:
            return "Sadly No 😔"
        }
    }
}
