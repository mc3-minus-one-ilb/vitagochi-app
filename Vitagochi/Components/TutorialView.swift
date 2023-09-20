//
//  TutorialView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 07/09/23.
//

import SwiftUI

enum TutorialStepEnum: Int {
    case gettingStart = 0
    case photographMeals = 1
    case mealProgress = 2
    case vitaLevelUp = 3
    
    var title: String {
        switch self {
        case .gettingStart:
            return "Getting Start"
        case .photographMeals:
            return "Photograph Meals"
        case .mealProgress:
            return "Today's Meal Progress"
        case .vitaLevelUp:
            return "Vita Level Up!"
        }
    }
    
    var description: String {
        switch self {
        case .gettingStart:
            return "Tap Vita, so she can make a sound\n" +
            "that remind you to eat"
        case .photographMeals:
            return "Take a picture of your meal as \n" +
            "proof that you eat healthy food"
        case .mealProgress:
            return "The circular progress bar will be\n" +
            "run after you take a picture"
        case .vitaLevelUp:
            return "Every first meal can filled this bar!\n" +
            "The moment it reach 20/20, Vita’s\n" +
            "appearance will improve!"
        }
    }
}
struct TutorialView: View {
    @Binding var isCompleted: Bool
    @Binding var stepNumber: Int
    
    
    var body: some View {
        let step: TutorialStepEnum = TutorialStepEnum.init(rawValue: stepNumber) ?? .gettingStart
        return VStack(alignment: .leading) {
            HStack {
                Text(step.title)
                    .font(.system(.subheadline, weight: .medium))
                    .foregroundColor(.blackGreen)
                Spacer()
                Text("(\(step.rawValue+1)/4)")
                    .font(.system(.subheadline, weight: .medium))
                    .foregroundColor(.mintDark)
                
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            Text(step.description)
                .font(.system(.subheadline, weight: .regular))
                .foregroundColor(.blackGreen)
         
//            Divider()
//                .padding(.top, 1)
//            //                            .fontWidth(22)
//                .background(Color.white)
            HStack {
                if step != .vitaLevelUp {
                    Button {
                        isCompleted.toggle()
                    } label: {
                        Text("Skip")
                            .font(.system(.headline, weight: .regular))
                            .fontDesign(.rounded)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .foregroundColor(.gray1)
                    }
                }
                Spacer()
                Button {
                    if step == .vitaLevelUp {
                        isCompleted.toggle()
                    } else {
                        stepNumber+=1
                    }
                } label: {
                    Text(step == .vitaLevelUp ? "Got It!" : "Next")
                        .font(.system(.headline, weight: .semibold))
                        .fontDesign(.rounded)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 24)
                        .foregroundColor(.mintDark)
                        .overlay(content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(Color.mintDark, lineWidth: 1)
                                    
                            
                        })
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
        }
        .padding(.horizontal, 16)
        .background(Color.whiteFull)
        .clipShape(step == .photographMeals ? RoundedCornersShape(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 12) :  RoundedCornersShape(corners: .allCorners, radius: 12))
        .kerning(-0.8)
        .overlay(alignment: .bottom) {
            if step != .photographMeals {
                Image(systemName: "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 30, height: 15)
                    .offset(y: 13)
                    .foregroundColor(.whiteFull)
            }
        }
        .shadow(color: .black.opacity(0.02),radius: 8, x: 2, y: 4)
        .fontDesign(.rounded)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            
            Color.black
            VStack {
                TutorialView(isCompleted: .constant(false), stepNumber: .constant(0))
                    .frame(width: 236)
                Spacer()
            }
        }
    }
}
