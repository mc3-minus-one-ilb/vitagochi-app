//
//  BadgesViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 20/08/23.
//

import SwiftUI

class BadgesViewModel: ObservableObject {
    @Published var items: [BadgeModel] = []
    
    init() {
        for badgeType in BadgeType.allCases {
            items.append(BadgeModel(type: badgeType))
        }
    }
}
