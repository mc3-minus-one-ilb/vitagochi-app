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
    var progress = 0
    var totalProgress = 11
    var body: some View {
        VStack(alignment: .center) {
            Image(badgeModel.type.image)
                .resizable()
                .foregroundColor(.backgroundBadge)
                .frame(width: 152, height: 152)
                .grayscale(isUnlocked ? 0 : 1)
            HStack(alignment: .center) {
                Text(badgeModel.type.name)
                    .font(.headline)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .padding(.leading, isUnlocked ? 0 : 16)
                
                if isUnlocked {
                    Image(systemName: "checkmark.seal.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.mintDark)
                } else  {
                    Text("(\(progress)/\(totalProgress))")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .fontDesign(.rounded)
                        .padding(.trailing)
                        .foregroundColor(.mintDark)
                }
            }
            .frame(minWidth: 190)
            .padding(.top, 5)
            .padding(.bottom, 1)
            
            Text(badgeModel.type.description)
                .font(.footnote)
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
//                .padding(.top, 1)
        }
        .padding(.top, 20)
        
    }
}

struct BadgeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgesView()
            .environmentObject(CoreDataEnvirontment.singleton)
    }
}
