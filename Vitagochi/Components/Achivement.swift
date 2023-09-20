//
//  Achivement.swift
//  Vitagochi
//
//  Created by Enzu Ao on 27/07/23.
//

import SwiftUI


struct AchievementView: View {
    var badgeType: BadgeType?
    var achievementType: AchievementEnum?
    @Binding var show: Bool
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
            GeometryReader { geo in
                VStack(spacing: 25) {
                    if let badgeType = badgeType {
                        
                        Image(badgeType.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 238, height: 238)
                            .clipShape(Rectangle())
                        //                                .offset(y: -30)
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Hooray! 🎉")
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.semibold)
                                .kerning(-0.8)
                            Group {
                                Text("This ") +
                                Text("'\(badgeType.name)' ")
                                    .fontWeight(.semibold)
                                + Text(badgeType.achievementDescription)
                            }
                            .font(.system(.body, weight: .regular))
                            .kerning(-0.8)
                            .multilineTextAlignment(.leading)
                            
                        }
                        .padding(.horizontal,35)
                    }
                    
                    if let achievementType = achievementType {
                        Image(achievementType.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 281, height: 238)
                            .padding(.leading,15)
                            .clipShape(Rectangle())
                        //                                .offset(y: -30)
                        VStack(alignment: .leading, spacing: 20) {
                            Text(achievementType.title)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.semibold)
                                .kerning(-0.8)
                            Text(achievementType.description)
                                .font(.system(.body, weight: .regular))
                                .kerning(-0.8)
                                .multilineTextAlignment(.leading)
                            
                        }
                        .padding(.leading,15)
        
                    }
                }
                .padding(.top,70)
                
                Button {
                    show.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.gray1)
                }
                .offset(x: geo.size.width * 0.87, y: geo.size.height * 0.05)
            }
            
            .frame(width: 326, height: 537)
            //            .padding(.vertical, 40)
            //            .padding(.horizontal, 30)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.16), radius: 12, x: -4, y: 0)
            
            
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

struct Achievement_Preview: PreviewProvider {
    static var previews: some View {
        AchievementView(achievementType: .secondOrThirdMeal, show: .constant(true))
    }
}
