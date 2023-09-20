//
//  GalleryCard.swift
//  Vitagochi
//
//  Created by Enzu Ao on 23/07/23.
//

import SwiftUI

struct GalleryCard: View {
    var card: Card
    var isFlipped: Bool = false
    
    var body: some View {
//        let now = Date()
//        let isItPast = now.isItPast(date: cardDate)
//        let isItPassMealTime = !isItPast && now.isPhaseGreaterThan(timePhase.nextPhase)
        let timeHour = card.time?.getFormattedTime() ?? ""
        return GeometryReader { geometry in
            VStack(alignment: .leading) {
                if !isFlipped {
                    if let photo = card.mainPhoto {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.65)
                            .clipped()
                            .contentShape(Rectangle())
                    } else {
                        Image("NoPhoto")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.65)
                            .clipped()
                            .contentShape(Rectangle())
                        
                    }
                    HStack(alignment: .top, spacing: 0) {
                        Rectangle()
                            .foregroundColor(.blackGreen)
                            .frame(width: 4, height: 24)
                        GeometryReader { _ in
                            VStack(alignment: .leading) {
                                Text("\(card.phase.mealTime) \(card.phase.mealTimeIcon)")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.blackGreen)
                                    .padding(.horizontal)
                                    .padding(.bottom, 1)
                                
                                Text(card.message)
                                    .font(.system(size: 15))
                                    .foregroundColor(.blackGreen)
                                    .fontWeight(.regular)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.top)
                    .frame(height: geometry.size.height * 0.30)
                    
                } else {
                    Image(card.phase.mealBackground)
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.65)
                        .clipped()
                        .contentShape(Rectangle())
                        
                    
                    HStack(alignment: .top, spacing: 0) {
                        Rectangle()
                            .foregroundColor(.blackGreen)
                            .frame(width: 4, height: 24)
                        GeometryReader { _ in
                            VStack(alignment: .leading) {
                                Text("\(card.phase.mealTime) \(card.phase.mealTimeIcon)")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundColor(.blackGreen)
                                    .padding(.horizontal)
                                    .padding(.bottom, 1)
                                
                                Text(timeHour.isEmpty ? "You haven't eat any meals" : "You had already eat at\n\(timeHour)")
                                    .font(.system(size: 15))
                                    .foregroundColor(.blackGreen)
                                    .fontWeight(.regular)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.leading)
                    .padding(.top)
                    .frame(height: geometry.size.height * 0.30)
                }
            }
//            .padding(.bottom, 50)
            
            .background(Color.whiteFull)
            .cornerRadius(16)
           
            
            //            .shadow(radius: 2)
        }
    }
}

struct GalleryCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            let phase: VitaTimePhase = .morning
            let card = Card(phase: phase,
                            message: phase.mealQuote,
                            mainPhoto: nil,
                            time: nil)
            GalleryCard(card: card, isFlipped: true)
                .frame(width: 269, height: 508)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
