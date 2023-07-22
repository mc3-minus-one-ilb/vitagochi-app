//
//  MainView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @State private var selection: Int = 0
    
    var body: some View {
        
        // BUG: Offset Problem
        // BUG: MainScene position is terrible
        
        NavigationStack{
            ScrollView(.init()){
                ZStack(alignment: .bottom){
                    TabView(selection: $selection) {
                        MainSceneView()
                            .tag(0)
                        TrackingProgressView()
                            .tag(1)
                        ChatView(timePhase: .morning)
                            .tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .animation(.easeOut(duration: 1.0), value: selection)
                }
            }
            .ignoresSafeArea()
            .safeAreaInset(edge: .bottom) {
                HStack{
                    TabBarIconView(selection: $selection, value: 0, iconName: "heart.fill")
                        .padding(.leading, 50)
                    Spacer()
                    TabBarIconView(selection: $selection, value: 1, iconName: "heart.text.square.fill")
                    Spacer()
                    TabBarIconView(selection: $selection, value: 2, iconName: "medal.fill")
                        .padding(.trailing, 50)
                }
                .background(Color.primaryWhite)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        return RootView()
            .environmentObject(GlobalEnvirontment.singleton)
            .environmentObject(CoreDataEnvirontment.singleton)
        
        //        RootView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        //            .previewDisplayName("iPhone 14 Pro Max")
        //
        //        RootView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        //            .previewDisplayName("iPhone SE (3rd generation)")
        
    }
}
