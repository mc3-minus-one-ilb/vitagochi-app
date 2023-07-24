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
    var body: some View {
        VStack{
            if isLocked {
                Image("ProgressLockedIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
            } else if progress < 3 && progress >= 0 {
                ZStack(alignment: .center){
                    CircularProgressView(percentage: Double(progress * 34), lineWitdh: 6, isBackgroundColor: false)
                        .frame(width: 40, height: 40)
                    Text("\(progress)/3")
                        .font(.system(size:11))
                }
            } else if progress >= 3 {
                Image("ProgressCompleteIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            
            Text("Day \(dayNumber)")
                .font(.system(size:11))
                .padding(.top, 4)
        }
    }
}

struct CricularProgressSection_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressSection(dayNumber: 1, progress: 3, isLocked: true)
    }
}
