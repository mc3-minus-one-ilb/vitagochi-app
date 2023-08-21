//
//  LevelUpViewModel.swift
//  Vitagochi
//
//  Created by Dzulfikar on 20/07/23.
//

import Foundation

class LevelUpViewModel: ObservableObject {
    public static var singleton: LevelUpViewModel = LevelUpViewModel()
    
    @Published var levelProgress = 0.0
    @Published var maxTotalLevel = 20.0
    @Published var isEvolving = false
    @Published var level = 0
    @Published var isLevelUp: Bool = false
}
