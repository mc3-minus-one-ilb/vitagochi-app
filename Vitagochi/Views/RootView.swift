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
    @StateObject private var rootVM: RootViewModel = RootViewModel()
    
    var body: some View {
        NavigationStack(path: $envObj.path) {
            ZStack {
                ScrollView(.init()) {
                    TabView(selection: $rootVM.selection) {
                        MainView()
                            .tag(rootVM.mainViewTag)
                        TrackingProgressView()
                            .tag(rootVM.progressViewTag)
                        BadgesView()
                            .tag(rootVM.badgesViewTag)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .background(Image("Background").resizable().aspectRatio(contentMode: .fit))
                .ignoresSafeArea()
                .safeAreaInset(edge: .bottom) {
                    HStack {
                        TabBarIconView(selection: $rootVM.selection,
                                       value: rootVM.mainViewTag,
                                       iconName: "heart.fill")
                            .transition(.slide)
                            .padding(.leading, 50)
                        Spacer()
                        TabBarIconView(selection: $rootVM.selection,
                                       value: rootVM.progressViewTag,
                                       iconName: "heart.text.square.fill")
                            .transition(.slide)
                        Spacer()
                        TabBarIconView(selection: $rootVM.selection,
                                       value: rootVM.badgesViewTag,
                                       iconName: "medal.fill")
                            .transition(.slide)
                            .padding(.trailing, 50)
                    }
                    .background(Color.primaryWhite)
                }
                
//                Button {
//                    withAnimation(.easeIn(duration: 2)) {
//                        self.achievement.toggle()
//                    }
//                } label: {
//                    Text("Hello")
//                }

                if rootVM.achievement {
                    AchievementView(badgeType: rootVM.newBadge,
                                    show: $rootVM.achievement)
                        .ignoresSafeArea()
                        .zIndex(2)
                }
            }
            .onChange(of: coreData.newBadge) { newValue in
                if let value = newValue {
                    if let badge = BadgeType(rawValue: value.badgeId) {
                        rootVM.achievement.toggle()
                        rootVM.newBadge = badge
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
