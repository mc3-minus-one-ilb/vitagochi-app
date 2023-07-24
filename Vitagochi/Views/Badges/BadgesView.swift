//
//  BadgesView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 24/07/23.
//

import SwiftUI

struct BadgeModel: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var subTitle: String
}

struct Badge: View {
    var badgeModel: BadgeModel
    var body: some View {
        VStack(alignment: .center) {
            Circle()
                .foregroundColor(.backgroundBadge)
                .frame(width: 152)
            Text(badgeModel.title)
                .font(.headline)
                .fontDesign(.rounded)
                .fontWeight(.medium)
                .padding(.top, 5)
                .padding(.bottom, 1)
            Text(badgeModel.subTitle)
                .font(.caption2)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
//                .padding(.top, 1)
        }
        .padding(.top, 20)
    }
}
struct BadgesView: View {
    var items = [BadgeModel(title: "Energize Lunch",
                            subTitle: "Eat Healthy Lunch\nfor 22 times"),
                 BadgeModel(title: "Morning Task",
                            subTitle: "Eat Healthy Breakfast\nfor 11 times"),
                 BadgeModel(title: "Sun & Noon Feast",
                            subTitle: "Eat Healthy Breakfast\nfor 11 times"),
                 BadgeModel(title: "Dinnertime Delight",
                            subTitle: "Eat Healthy Dinner\nfor 22 times"),
                 BadgeModel(title: "Twilight Tasting",
                            subTitle: "Eat Healthy Lunch & Dinner\nfor 33 times"),
                 BadgeModel(title: "3 Times Meals",
                            subTitle: "3x Healthy Meals in a Day\nfor 44 times")]
    
    let gridItems = [GridItem(.flexible()),GridItem(.flexible())]
    
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
                        Badge(badgeModel: item)
                    }
                }
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
    }
}
