//
//  MainSceneViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI

class MainSceneViewModel: ObservableObject {
    @Published var phase: VitachiTimePhase = .beforeDayStart
    @Published var mood: VitachiMoodPhase = .idle
    @Published var message: String = ""
    @Published var isCompleted: [Bool] =  [true, false, false, false]
    @Published var isTapped: Bool = false
    
    
    init() {
        CheckPhaseTime()
        print("Init VitaViewModel.Phase \(self.phase)")
        GenerateMessage()
    }
    
    func CheckPhaseTime() {
        let now = Date()
        if now.isPhaseGreaterThan(.evening) {
            self.phase = .evening
        } else if now.isPhaseGreaterThan(.afternoon) {
            self.phase = .afternoon
        } else if now.isPhaseGreaterThan(.morning) {
            self.phase = .morning
        } else if now.isPhaseGreaterThan(.beforeDayStart) {
            self.phase = .beforeDayStart
        }
//        print("CheckPasheTime VitaViewModel.Phase \(self.phase)")
    }
    
    func GenerateMessage() {
        if phase == .beforeDayStart {
            self.message = phase.defaultMessage[isTapped ? 1 : 0].text
            return
        }
        if Date().isPhaseAfterOneHour(phase) && !isCompleted[phase.completedIndex] {
            self.mood = .angry
            self.message = phase.angryMessage[isTapped ? 1 : 0].text
        } else if isCompleted[phase.completedIndex] {
            self.mood = .happy
            self.message = phase.happyMessage[isTapped ? 1 : 0].text
        } else {
            self.mood = .idle
            self.message = phase.defaultMessage[isTapped ? 1 : 0].text
        }
//        print("message : \(message)")
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
