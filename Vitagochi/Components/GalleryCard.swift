//
//  GalleryCard.swift
//  Vitagochi
//
//  Created by Enzu Ao on 23/07/23.
//

import SwiftUI

struct GalleryCard: View {
    var photo: UIImage?
    var timePhase: VitachiTimePhase = .morning
    var time: Date?
    var isFlipped: Bool = true
    var vitaMessage: String = ""
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading) {
                if !isFlipped{
                    if let photo = photo {
                        Image(uiImage: photo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.75)
                            .clipped()
                            .contentShape(Rectangle())
                    } else  {
                        Image("NoPhoto")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.75)
                            .clipped()
                            .contentShape(Rectangle())
                    }
                    
                    Text(timePhase.mealTime)
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    Text(time?.getFormattedTime() ?? timePhase.mealTimeIcon)
                        .font(.system(size: 15))
                        .fontWeight(.medium)
                        .padding(.horizontal)
                    
                } else {
                    Image(timePhase.mealBackground)
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.6)
                        .clipped()
                        .contentShape(Rectangle())
                        
                        
                    Text("\(timePhase.mealTime) \(timePhase.mealTimeIcon)")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal)
            
                    Text(vitaMessage != "" ? vitaMessage : timePhase.mealQuote)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.top, 4)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 70)
            .background(isFlipped ? Color.chatTopPinkColor : Color.white)
            .cornerRadius(16)
            
            //            .shadow(radius: 2)
        }
    }
}

struct GalleryCard_Previews: PreviewProvider {
    static var previews: some View {
        GalleryCard()
            .frame(width: 269,height: 508)
            .padding()
    }
}
