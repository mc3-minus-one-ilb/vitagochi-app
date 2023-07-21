//
//  LevelUpViewModel.swift
//  Vitagochi
//
//  Created by Dzulfikar on 20/07/23.
//

import Foundation


class LevelUpViewModel: ObservableObject {
    public static var singleton: LevelUpViewModel = LevelUpViewModel()
    
    @Published var levelProgress = 1.0
    @Published var maxTotalLevel = 20.0
}
