//
//  TabBarIconView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI

struct TabBarIconView: View {
    @Binding var selection: Int
    let value: Int
    let iconName: String
    var body: some View {
        ZStack{
            if selection == value{
                Rectangle()
                    .foregroundColor(.circularProgressOutline)
                    .cornerRadius(20)
                    .frame(width: 64, height: 4, alignment: .center)
                    .offset(y:-23)
            }
            Button {
                self.selection = value
            } label: {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23, height: 21, alignment: .center)
                    .foregroundColor(selection == value ? Color.activeIconTabBar : Color.inactiveIconTabBar)
            }
        }
        .frame(width: 70, height: 50)
    }
}

struct TabBarIconView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarIconView(selection: .constant(0), value: 0, iconName: "heart.fill")
    }
}
