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
    var vitaAnswer: VitaChatAnswer?
}

enum VitaChatAnswer: Int16, CaseIterable {
    case exactly = 0
    case greensOnly = 1
    case fruitsOnly = 2
    case sadlyNo = 3
    
    func getAnswer(name: String = "") -> String {
        switch self {
        case.exactly:
            return "Finally you did it! Congratulations on " +
            "take a little step of embracing a " +
            "healthy dietary habit 🎉"
        case.greensOnly:
            return "Cool, you can eat fruit later! Vita knows that " +
            "you can't afford fruits because it's kinda pricy 😉"
        case.fruitsOnly:
            return "Wow, your palette just like a kid who dislike veggies. " +
            "Show me you are an adult by eating it later, okay? 😉"
        case.sadlyNo:
            return "Huft... \(name.isEmpty ? "you" : name) can be " +
            "disappointing at times. Promise me " +
            "you'll munch on greens and fruits next time, alright ? 😔"
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
    
    var labelConfirmation: String {
        switch self  {
        case.exactly:
            return "Thanks Vita!"
        case.fruitsOnly, .greensOnly:
            return "Okay Vita!"
        case.sadlyNo:
            return "Noted Vita!"
        }
    }
}
