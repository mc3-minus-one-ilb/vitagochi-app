//
//  MainView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appCoreRepo: AppCoreRepo
    @State var selection: Int = 0
    
    var body: some View {
        
        // BUG: Offset Problem
        // BUG: MainScene position is terrible
        NavigationStack{
            TabView(selection: $selection) {
                MainSceneView()
                    .tag(0)
                EmptyView()
                    .tag(1)
                EmptyView()
                    .tag(2)
            }
            .overlay(
                Color.primaryWhite
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(height: 50)
                    .overlay {
                        HStack{
                            TabBarIconView(selection: $selection, value: 0, iconName: "heart.fill")
                                .padding(.leading, 50)
                            Spacer()
                            TabBarIconView(selection: $selection, value: 1, iconName: "heart.text.square.fill")
                            Spacer()
                            TabBarIconView(selection: $selection, value: 2, iconName: "medal.fill")
                                .padding(.trailing, 50)
                        }
                    }
                ,alignment: .bottom)
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        return RootView().environmentObject(AppCoreRepo())
        
        //        RootView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        //            .previewDisplayName("iPhone 14 Pro Max")
        //
        //        RootView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        //            .previewDisplayName("iPhone SE (3rd generation)")
        
    }
}
