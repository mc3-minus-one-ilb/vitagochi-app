//
//  TabBarIconView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI

struct TabBarIconView: View {
    @Binding var selection: Int
    let tabBarNamespace: Namespace.ID
    let value: Int
    let iconName: String
    let label: String
    var body: some View {
        ZStack {
            if selection == value {
                Rectangle()
                    .foregroundColor(.mintPrimary)
                    
                    .cornerRadius(4)
                    .frame(width: 50, height: 4, alignment: .center)
                    .offset(y: -23)
                    .matchedGeometryEffect(id: "tabBarSelection", in: tabBarNamespace)
                    
            }
            Button {
                withAnimation(.easeIn(duration: 0.2)) {
                    self.selection = value
                }
                
            } label: {
                VStack(spacing:4) {
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 23, height: 27, alignment: .center)
                        .foregroundColor(selection == value ?
                                         Color.blackGreen : Color.gray1)
                    Text(label)
                        .font(.caption2)
//                        .fontWeight(.regular)
                        .foregroundColor(selection == value ?
                                         Color.blackGreen : Color.gray1)
                }
                .padding(.top)
            }
        }
        .frame(width: 70, height: 50)
    }
}

struct TabBarIconView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        TabBarIconView(selection: .constant(0),
                       tabBarNamespace: namespace,
                       value: 0,
                       iconName: "fork.knife",
                       label: "Meals")
    }
}
