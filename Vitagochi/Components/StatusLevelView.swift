//
//  StatusLevelView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct StatusLevelView: View {
    var level: Int
    var exp: Int
    var body: some View {
//        HStack(spacing: 10){
//            Text("Level \(level)")
//                .font(.system(size: 11,weight: .regular, design: .rounded))
//
//            GeometryReader{ geo in
//                Rectangle()
//                    .fill(Color.white)
//                    .frame(width: geo.frame(in: .local).width, height: geo.size.height)
//                    .cornerRadius(200)
//            }
//            Text("\(exp)/22")
//                .font(.system(size: 11,weight: .regular, design: .rounded))
//        }
        ProgressView(value: CGFloat(exp), total: CGFloat(20), label: {
            Text("Level \(level)")
        }, currentValueLabel: {
            Text("\(exp)/20")
        }).progressViewStyle(MainSceneLevelUpProgressStyle( height: 10))
        
        
    }
}

struct StatusLevelView_Previews: PreviewProvider {
    static var previews: some View {
        StatusLevelView(level: 1, exp: 20)
            .frame(width: 250, height: 10)
    }
}
