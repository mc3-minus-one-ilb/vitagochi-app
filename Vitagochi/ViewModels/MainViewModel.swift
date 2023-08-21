//
//  MainSceneViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 18/07/23.
//

import SwiftUI
import AVFoundation

// Testing

class MainViewModel: ObservableObject {
    @Published var vitaPhase: VitaTimePhase = .beforeDayStart
    @Published var vitaMood: VitaMoodPhase = .idle
    @Published var vitaSkin: VitaSkinModel = .casual
    @Published var vitaMessage: VitaMessage = VitaMessage(text: "",
                                                          soundFileName: "")
    @Published var vitaSkinImageName: String = ""
    @Published var isTapped: Bool = false
    @Published var isCameraClicked: Bool = false
    @Published var imageData: Data = Data(count: 0)
    @Published var currentTime: Date = Date()
    @Published var timer: Timer?
    @Published var skinTimer: Timer?
    var charSound: AVAudioPlayer = AVAudioPlayer()
    var isFirstTimeModel: Bool = true
    
    @Published var mealDatas: [ChallangeEntity] = []
    
    init(vitaSkin: VitaSkinModel, vitaMood: VitaMoodPhase) {
        
        self.vitaSkin = vitaSkin
        self.vitaMood = vitaMood
        
        checkPhaseTime()
        runAnimation()
    }
    
    func runAnimation() {
        skinTimer?.invalidate()
        skinTimer = nil
        
        var index = 1
        
        self.skinTimer = Timer.scheduledTimer(withTimeInterval: 0.083, repeats: true) { (_) in
            self.vitaSkinImageName = "\(self.vitaSkin.skin)-\(self.vitaMood.skin)-\(index)"
            
            index += 1
            if index > self.vitaSkin.maxFrame(mood: self.vitaMood) {
                index = 1
            }
        }
        
    }
    
    func checkPhaseTime() {
        let now = Date()
        if now.isPhaseGreaterThan(.afterDay) {
            self.vitaPhase = .afterDay
        } else if now.isPhaseGreaterThan(.evening) {
            self.vitaPhase = .evening
        } else if now.isPhaseGreaterThan(.afternoon) {
            self.vitaPhase = .afternoon
        } else if now.isPhaseGreaterThan(.morning) {
            self.vitaPhase = .morning
        } else if now.isPhaseGreaterThan(.beforeDayStart) {
            self.vitaPhase = .beforeDayStart
        }
    }
    
    func generateMessage(for todayChallange: ChallangeEntity?, isFirstTime: Bool = false) {
        if charSound.isPlaying { return }
        
        if isFirstTime && self.isFirstTimeModel {
            self.isFirstTimeModel = false
            self.vitaMessage = vitaFirstTimeAppMessage
            playSound()
            return
        }
        
        var vitaMood: VitaMoodPhase = .idle
        var isAfterSick: Bool = false
        
        if let records = todayChallange?.records?.allObjects as? [MealRecordEntity] {
            let isComplete = records.contains {$0.timeStatus == vitaPhase.rawValue}
            let countRecord = records.count
            
            if self.vitaMood == .sick && countRecord == 0 {
                vitaMood = .sick
            } else if Date().isPhaseAfterOneHour(vitaPhase) && !isComplete {
                vitaMood = .angry
            } else if isComplete {
                vitaMood = .happy
                if self.vitaMood == .sick && countRecord == 1 {
                    isAfterSick = true
                }
            }
        }
        
        self.vitaMood = vitaMood
        self.vitaMessage = vitaMood.getMessage(vitaPhase: vitaPhase,
                                               isTapped: isTapped,
                                               isAfterSick: isAfterSick)
        
        playSound()
    }
    
    func vitaIsTapped() {
        isTapped.toggle()
    }
    
    func runTimerForCheckPhaseTime() {
        self.timer?.invalidate()
        self.timer = nil
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.checkPhaseTime()
            self.currentTime = Date()
        }
    }
    
    private func playSound() {
        
//        var file = vitaMessage.soundFileName
//        if file.isEmpty {
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
