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
    @Published var vitaSkin: VitaSkinModel = .casual
    @Published var message: String = ""
    @Published var isCompleted: [Bool] =  [true, false, false, false, true]
    @Published var isTapped: Bool = false
    @Published var isCameraClicked: Bool = false
    @Published var imageData: Data = Data(count: 0)
    @Published var currentTime: Date = Date()
    @Published var timer: Timer?
    @Published var skinTimer: Timer?
    @Published var skin: String = ""
    var charSound: AVAudioPlayer = AVAudioPlayer()
    var soundFileName: String = ""
    var isFirstTimeModel: Bool = true
    
    @Published var mealDatas: [ChallangeEntity] = []
    
    
    
    init() {
        CheckPhaseTime()
        print("Init VitaViewModel.Phase \(self.phase)")
        runAnimation()
        let coreData = CoreDataEnvirontment.singleton
        self.vitaSkin = coreData.vitaSkinModel
        self.mood = coreData.checkYesterdayHasNoRecord() ? .sick : .idle
        
    }
    
    //    func getMealRecordData() {
    //        DispatchQueue.main.async {
    //            self.mealDatas = self.mealRecordRepository.getChallanges()
    //            print("REPOPATTERN")
    //            print(self.mealDatas)
    //        }
    //    }
    
    func runAnimation() {
        skinTimer?.invalidate()
        skinTimer = nil
        
        var index = 1
        
        
        self.skinTimer = Timer.scheduledTimer(withTimeInterval: 0.083, repeats: true) { (Timer) in
            self.skin = "\(self.vitaSkin.skin)-\(self.mood.skin)-\(index)"
            
            index += 1
            if (index > self.vitaSkin.maxFrame(mood: self.mood)) {
                index = 1
            }
        }
        
    }
    
    func CheckPhaseTime() {
        let now = Date()
        if now.isPhaseGreaterThan(.afterDay){
            self.phase = .afterDay
        } else if now.isPhaseGreaterThan(.evening){
            self.phase = .evening
        } else if now.isPhaseGreaterThan(.afternoon) {
            self.phase = .afternoon
        } else if now.isPhaseGreaterThan(.morning) {
            self.phase = .morning
        } else if now.isPhaseGreaterThan(.beforeDayStart) {
            self.phase = .beforeDayStart
        }
        //        if self.mood != .sick { self.mood = .idle }
        //        if now.isPhaseGreaterThan(.afterDay){
        //            self.phase = .afterDay
        //        } else if now.isPhaseGreaterThan(time: envObj.dinnerReminder){
        //            self.phase = .evening
        //        } else if now.isPhaseGreaterThan(time: envObj.lunchReminder) {
        //            self.phase = .afternoon
        //        } else if now.isPhaseGreaterThan(time: envObj.breakfastReminder) {
        //            self.phase = .morning
        //        } else if now.isPhaseGreaterThan(.beforeDayStart) {
        //            self.phase = .beforeDayStart
        //        }
        //        print("CheckPasheTime VitaViewModel.Phase \(self.phase)")
    }
    
    func GenerateMessage(for todayChallange: ChallangeEntity?, isFirstTime: Bool = false) {
        if charSound.isPlaying {
            return
        }
        //
        if isFirstTime && self.isFirstTimeModel {
            self.isFirstTimeModel = false
            self.message = VitaFirstTimeApp.text
            self.soundFileName = VitaFirstTimeApp.soundFile
            PlaySound()
            return
        }
        
        if let records = todayChallange?.records?.allObjects as? [MealRecordEntity] {
            let isComplete = records.contains{$0.timeStatus == phase.rawValue}
            let countRecord = records.count
            
            if self.mood == .sick && countRecord == 0{
                self.message = VitaSickMessage[isTapped ? 1 : 0].text
                self.soundFileName = VitaSickMessage[isTapped ? 1 : 0].soundFile
            } else if phase == .afterDay {
                self.mood = .idle
                self.message = phase.defaultMessage[isTapped ? 1 : 0].text
                self.soundFileName = phase.defaultMessage[isTapped ? 1 : 0].soundFile
            }else if phase == .beforeDayStart {
                self.mood = .idle
                self.message = phase.defaultMessage[isTapped ? 1 : 0].text
                self.soundFileName = phase.defaultMessage[isTapped ? 1 : 0].soundFile
            } else if Date().isPhaseAfterOneHour(phase) && !isComplete {
                self.mood = .angry
                self.message = phase.angryMessage[isTapped ? 1 : 0].text
                self.soundFileName = phase.angryMessage[isTapped ? 1 : 0].soundFile
            } else if isComplete {
                if self.mood == .sick && countRecord == 1{
                    self.mood = .happy
                    self.message =  VitaSickMessage[2].text
                    self.soundFileName = VitaSickMessage[2].soundFile
                } else {
                    self.mood = .happy
                    self.message = phase.happyMessage[isTapped ? 1 : 0].text
                    self.soundFileName = phase.happyMessage[isTapped ? 1 : 0].soundFile
                }
            } else {
                self.mood = .idle
                self.message = phase.defaultMessage[isTapped ? 1 : 0].text
                self.soundFileName = phase.defaultMessage[isTapped ? 1 : 0].soundFile
            }
        } else {
            self.mood = .idle
            self.message = phase.defaultMessage[isTapped ? 1 : 0].text
            self.soundFileName = phase.defaultMessage[isTapped ? 1 : 0].soundFile
        }
        
        PlaySound()
        //        print("message : \(message)")
    }
    
    func PlaySound() {
        
        var file = soundFileName
        if file == "" {
            file = "welcome"
        }
        guard let soundPath =  Bundle.main.path(forResource: file, ofType: "wav") else {
            print("Error file not found")
            return
        }

        let fileURL = URL(filePath: soundPath)

        do {
            charSound = try AVAudioPlayer(contentsOf: fileURL)
            charSound.prepareToPlay()
            charSound.volume = 1.0
            charSound.play()
        } catch {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView()
//    }
//}
