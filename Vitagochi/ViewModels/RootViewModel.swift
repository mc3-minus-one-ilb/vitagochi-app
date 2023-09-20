//
//  RootViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 16/08/23.
//

import SwiftUI

extension RootView {
    class RootViewModel: ObservableObject {
        @Published var selection: Int = 0
        @Published var achievement: Bool = false
        @Published var newBadge: BadgeType?
        @Published var newAchievement: AchievementEnum?
        let mainViewTag = 0
        let progressViewTag = 1
        let badgesViewTag = 2
    }
}
