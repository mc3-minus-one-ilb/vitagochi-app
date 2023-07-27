//
//  MainView.swift
//  Vitagochi
//
//  Created by Enzu Ao on 17/07/23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var envObj: GlobalEnvirontment
    @EnvironmentObject private var coreData: CoreDataEnvirontment
    @State private var selection: Int = 0
    @State private var achievement: Bool = false
    @State private var newBadge: BadgeType = .energizeLunch
    
    
    var body: some View {
        
        NavigationStack(path: $envObj.path){
            ZStack {
                
                ScrollView(.init()){
                    
                    TabView(selection: $selection) {
                        MainSceneView()
                            .tag(0)
                        TrackingProgressView()
                            .tag(1)
                        BadgesView()
                            .tag(2)
                    }
                    .animation(.easeOut(duration: 1.0), value: selection)
                    .transition(.slide)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                }
                .background(Image("Background").resizable().aspectRatio(contentMode: .fit))
                .ignoresSafeArea()
                .safeAreaInset(edge: .bottom) {
                    HStack{
                        TabBarIconView(selection: $selection, value: 0, iconName: "heart.fill")
                            .transition(.slide)
                            .padding(.leading, 50)
                        Spacer()
                        TabBarIconView(selection: $selection, value: 1, iconName: "heart.text.square.fill")
                            .transition(.slide)
                        Spacer()
                        TabBarIconView(selection: $selection, value: 2, iconName: "medal.fill")
                            .transition(.slide)
                            .padding(.trailing, 50)
                    }
                    .animation(.easeInOut, value: selection)
                    .background(Color.primaryWhite)
                }
                
//                Button {
//                    withAnimation(.easeIn(duration: 2)) {
//                        self.achievement.toggle()
//                    }
//                } label: {
//                    Text("Hello")
//                }

                if achievement {
                    AchievementView(badgeType: newBadge,show: $achievement)
                        .ignoresSafeArea()
                        .zIndex(2)
                }
            }
            .onChange(of: coreData.newBadge) { newValue in
                if let value = newValue {
                    if let badge = BadgeType(rawValue: value.badgeId) {
                        achievement.toggle()
                        newBadge = badge
                    }
                }
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
