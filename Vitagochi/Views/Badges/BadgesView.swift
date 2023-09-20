//
//  BadgesView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 24/07/23.
//

import SwiftUI

struct BadgesView: View {
    @EnvironmentObject private var coreDataEnv: CoreDataEnvirontment
    @StateObject  private var badgesVM: BadgesViewModel = BadgesViewModel()
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Badges 🏅")
                .font(.title)
                .fontDesign(.rounded)
                .bold()
                .padding(.leading, 16)
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: gridItems) {
                    ForEach(badgesVM.items) { item in
                        if coreDataEnv.badges.contains(where: { badgeData in
                            badgeData.badgeId == item.type.rawValue }) {
                            BadgeView(badgeModel: item, isUnlocked: true)
                        } else {
                            let progress = coreDataEnv
                                .countBadgesProgress(badge: item.type)
                            BadgeView(badgeModel: item,
                                      progress: progress,
                                      totalProgress: item.type.daysToAchiveBadge)
                        }
                        
                    }
                }
                .padding(.bottom, 120)
            }
        }
        .padding()
        .padding(.top, 50)
        .background(Color.whiteGrayish)
        .ignoresSafeArea()
    }
}

struct BadgesView_Previews: PreviewProvider {
    static var previews: some View {
        BadgesView()
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
