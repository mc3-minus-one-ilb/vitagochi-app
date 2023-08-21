//
//  CricularProgressSection.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct CircularProgressSection: View {
    var dayNumber: Int
    var progress: Int
    var isLocked: Bool
    var isHighlighted: Bool
    var body: some View {
        VStack {
            if isLocked {
                
                Image("ProgressLockedIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
                
            } else if progress < 3 && progress >= 0 {
                
                ZStack(alignment: .center) {
                    CircularProgressView(
                        percentage: Double(progress * 34),
                        lineWitdh: 6,
                        whiteBackgroundColor: true,
                        whiteOutlineColor: false)
                        .frame(width: 40, height: 40)
                    Text("\(progress)/3")
                        .font(.system(size: 11))
                }
                
            } else if progress >= 3 {
                
                Image("ProgressCompleteIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
                
            }
            
            HStack(alignment: .top) {
                if isHighlighted {
                    Rectangle()
                        .foregroundColor(.chatTopPinkColor)
                        .frame(width: 4, height: 8)
                        .cornerRadius(8)
                        .offset(x: 5, y: 4)
                }
                Text("Day \(dayNumber)")
                    .font(.system(size: 11))
                    .fontWeight(isHighlighted ? .bold : .regular)
                    .padding(.top, 4)
            }
            
        }
    }
}

struct CricularProgressSection_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressSection(dayNumber: 1, progress: 2, isLocked: false, isHighlighted: true)
    }
}
