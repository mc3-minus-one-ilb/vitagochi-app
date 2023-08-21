//
//  TabBarSection.swift
//  Vitagochi
//
//  Created by Enzu Ao on 22/07/23.
//

import SwiftUI

struct TabBarSection: View {
    @Binding var selection: Int
    let value: Int
    let text: String
    var body: some View {
        ZStack {
//            if selection == value{
//                Rectangle()
//                    .foregroundColor(.circularProgressOutline)
//                    .frame(width: 128, height: 4, alignment: .center)
//                    .offset()
//            }
            Button {
                self.selection = value
            } label: {
                Color.clear
                    .overlay {
                        Text(text)
                            .fontWeight(selection == value ? .semibold : .regular)
                            .foregroundColor(.black)
                    }
                    .frame(width: UIScreen.main.bounds.size.width/3,
                           height: 39 )
            }
        }
    }
}

struct TabBarSection_Previews: PreviewProvider {
    static var previews: some View {
        TrackingProgressView()
    }
}
