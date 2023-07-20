//
//  MainSceneViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI
import AVFoundation

class MainSceneViewModel: ObservableObject {
    @Published var phase: VitachiTimePhase = .beforeDayStart
    @Published var mood: VitachiMoodPhase = .idle
    @Published var message: String = ""
    @Published var isCompleted: [Bool] =  [true, false, false, false]
    @Published var isTapped: Bool = false
    @Published var isCameraClicked: Bool = false
    @Published var imageData: Data = Data(count: 0)
//    var charSound: AVAudioPlayer = AVAudioPlayer()
    var soundFileName: String = ""
    
    
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
//        if charSound.isPlaying {
//            return
//        }
        if phase == .beforeDayStart {
            self.message = phase.defaultMessage[isTapped ? 1 : 0].text
            self.soundFileName = phase.defaultMessage[isTapped ? 1 : 0].soundFile
            PlaySound()
            return
        }
        if Date().isPhaseAfterOneHour(phase) && !isCompleted[phase.completedIndex] {
            self.mood = .angry
            self.message = phase.angryMessage[isTapped ? 1 : 0].text
            self.soundFileName = phase.angryMessage[isTapped ? 1 : 0].soundFile
        } else if isCompleted[phase.completedIndex] {
            self.mood = .happy
            self.message = phase.happyMessage[isTapped ? 1 : 0].text
            self.soundFileName = phase.happyMessage[isTapped ? 1 : 0].soundFile
        } else {
            self.mood = .idle
            self.message = phase.defaultMessage[isTapped ? 1 : 0].text
            self.soundFileName = phase.defaultMessage[isTapped ? 1 : 0].soundFile
        }
        PlaySound()
        //        print("message : \(message)")
    }
    
    func PlaySound() {
        
//        var file = soundFileName
//        if file == "" {
//            file = "welcome"
//        }
//        guard let soundPath =  Bundle.main.path(forResource: file, ofType: "wav") else {
//            print("Error file not found")
//            return
//        }
//
//        let fileURL = URL(filePath: soundPath)
//
//        do {
//            charSound = try AVAudioPlayer(contentsOf: fileURL)
//            charSound.prepareToPlay()
//            charSound.volume = 1.0
//            charSound.play()
//        } catch {
//            print("Error playing sound \(error.localizedDescription)")
//        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}