//
//  BadgeView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 27/07/23.
//

import SwiftUI

struct BadgeView: View {
    var badgeModel: BadgeModel
    var isUnlocked = false
    var body: some View {
        VStack(alignment: .center) {
            Image(badgeModel.type.image)
                .resizable()
                .foregroundColor(.backgroundBadge)
                .frame(width: 152, height: 152)
                .grayscale(isUnlocked ? 0 : 1)
            Text(badgeModel.type.name)
                .font(.headline)
                .fontDesign(.rounded)
                .fontWeight(.medium)
                .padding(.top, 5)
                .padding(.bottom, 1)
            Text(badgeModel.type.description)
                .font(.caption2)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
//                .padding(.top, 1)
        }
        .padding(.top, 20)
    }
}
