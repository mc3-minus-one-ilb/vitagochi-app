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
    @Namespace private var tabBarNamespace
    
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
                                       tabBarNamespace: tabBarNamespace,
                                       value: rootVM.mainViewTag,
                                       iconName: "fork.knife",
                                       label: "Meals")
                            .padding(.leading, 40)
                        Spacer()
                        TabBarIconView(selection: $rootVM.selection,
                                       tabBarNamespace: tabBarNamespace,
                                       value: rootVM.progressViewTag,
                                       iconName: "doc.text.image.fill",
                                       label: "Progress")
                        Spacer()
                        TabBarIconView(selection: $rootVM.selection,
                                       tabBarNamespace: tabBarNamespace,
                                       value: rootVM.badgesViewTag,
                                       iconName: "medal.fill",
                                       label: "Badges")
                            .padding(.trailing, 40)
                    }
                    .background(Color.white)
                }
                
//                Button {
//                    withAnimation(.easeIn(duration: 2)) {
//                        self.achievement.toggle()
//                    }
//                } label: {
//                    Text("Hello")
//                }

                if rootVM.achievement {
                    if let newBadge = rootVM.newBadge {
                        AchievementView(badgeType: newBadge,
                                        show: $rootVM.achievement)
                            .ignoresSafeArea()
                            .zIndex(2)
                    } else if let newAchievement = rootVM.newAchievement {
                        AchievementView(achievementType: newAchievement,
                                        show: $rootVM.achievement)
                            .ignoresSafeArea()
                            .zIndex(2)
                    }
                }
            }
            .kerning(-0.8)
            .onChange(of: coreData.newBadge) { newValue in
                if let value = newValue {
                    if let badge = BadgeType(rawValue: value.badgeId) {
                        rootVM.achievement.toggle()
                        rootVM.newBadge = badge
                    }
                }
            }
            .onChange(of: envObj.achievement) { achievement in
                if let achievement = achievement {
                    rootVM.achievement.toggle()
                    rootVM.newAchievement = achievement
                }
            }
            .onChange(of: rootVM.achievement) { newValue in
                if !newValue {
                    rootVM.newBadge = nil
                    rootVM.newAchievement = nil
                    envObj.achievement = nil
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    
    static var previews: some View {
        let coreDataManager = CoreDataManager(.inMemory)
        let coreDataRepository = CoreDataRepository(manager: coreDataManager)
        let coreDataEnv = CoreDataEnvirontment(repository: coreDataRepository)
        
        return RootView()
            .environmentObject(GlobalEnvirontment.singleton)
            .environmentObject(coreDataEnv)
        
        //        RootView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
        //            .previewDisplayName("iPhone 14 Pro Max")
        //
        //        RootView()
        //            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
        //            .previewDisplayName("iPhone SE (3rd generation)")
        
    }
}
