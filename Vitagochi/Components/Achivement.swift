//
//  Achivement.swift
//  Vitagochi
//
//  Created by Enzu Ao on 27/07/23.
//

import SwiftUI

struct AchievementView: View {
    var badgeType: BadgeType
    @Binding var show: Bool
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            VStack(spacing: 25) {
                Image(badgeType.image)
                    .resizable()
                    .frame(width: 225, height: 225)
                    .clipShape(Rectangle())
                
                Text("Hooray! Way to Go 🎉")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                    .kerning(-0.4)
                Text(badgeType.achievementDescription)
                    .font(.system(.subheadline, weight: .regular))
                    .kerning(-0.4)
                    .multilineTextAlignment(.center)
            }
            .padding(.vertical, 40)
            .padding(.horizontal, 30)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: .black.opacity(0.16), radius: 12, x: -4, y: 0)
            
            .offset(y: -40)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color.black.opacity(0.3)
                .onTapGesture {
                    withAnimation {
                        show.toggle()
                    }
                }
        )
    }
}
