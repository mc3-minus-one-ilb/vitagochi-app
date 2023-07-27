//
//  BadgesView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 24/07/23.
//

import SwiftUI


struct BadgesView: View {
    @EnvironmentObject private var coreData: CoreDataEnvirontment
    
    var items: [BadgeModel] = []
    
    let gridItems = [GridItem(.flexible()),GridItem(.flexible())]
    
    init() {
        for badgeType in BadgeType.allCases {
            items.append(BadgeModel(type: badgeType))
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Badges ✨")
                .font(.title)
                .fontDesign(.rounded)
                .bold()
                .padding(.leading, 16)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridItems) {
                    ForEach(items) { item in
                        if coreData.badges.contains(where: { badgeData in
                            badgeData.badgeId == item.type.rawValue
                        }) {
                            BadgeView(badgeModel: item, isUnlocked: true)
                        } else  {
                            BadgeView(badgeModel: item)
                        }
                        
                    }
                }
                .padding(.bottom, 120)
            }
        }
        .padding()
        .padding(.top, 50)
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct BadgesView_Previews: PreviewProvider {
    static var previews: some View {
        BadgesView()
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
