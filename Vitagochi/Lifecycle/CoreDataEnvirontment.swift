//
//  CoreDataViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 20/07/23.
//

import SwiftUI
import CoreData

class CoreDataEnvirontment: ObservableObject {
    public static let singleton: CoreDataEnvirontment = CoreDataEnvirontment(
        repository: CoreDataRepository.singleton)
    private var appCoreRepository: CoreDataRepository
    @Published var challenges: [ChallangeEntity] = []
    @Published var mealRecords: [MealRecordEntity] = []
    @Published var badges: [BadgeEntity] = []
    @Published var todayChallenge: ChallangeEntity?
    @Published var vitaSkinModel: VitaSkinModel = .casual
    @Published var newBadge: BadgeEntity?
    var isTomorrowStarting: Bool = false
    
    init(repository: CoreDataRepository) {
        self.appCoreRepository = repository
        fetchChallanges()
        fetchMealRecords()
        fetchBadges()
        if challenges.isEmpty {
            add66DaysOfChallanges()
        }
        setTodayChallange()
        getVitaModel()
    }
    
    func fetchChallanges() {
        self.challenges = appCoreRepository.getChallanges()
    }
    
    func fetchMealRecords() {
        self.mealRecords = appCoreRepository.getMealRecords()
    }
    
    func fetchBadges() {
        self.badges = appCoreRepository.getBadges()
    }
    
    func getTodayCompletedChallange() -> Int {
        return todayChallenge?.records?.count ?? 0
    }
    
    func setTodayChallange(_ date: Date = Date()) {
        let today = date
        var index = 1
        for challange in challenges {
            if let challangeDate = challange.date {
                if  today.isItToday(date: challangeDate) {
                    self.todayChallenge = challange
                    return
                }
                index+=1
            } else {
                index+=1
            }
        }
        if todayChallenge == nil && !isTomorrowStarting {
            self.todayChallenge = appCoreRepository.addChallenge(date: date, day: Int16(index))
            save()
        }
    }
    
    func checkAndAddBadge(phase: VitaTimePhase) {
        //        let daySinceStart = countHowManyDaySinceStart()
        //        if daySinceStart < 11 { return }
        // Fix This
        
        for type in BadgeType.allCases {
            var isAlreadeyHave = false
            
            for accquiredBadge in badges
            where accquiredBadge.badgeId == type.rawValue {
                isAlreadeyHave = true
                continue
            }
            
            if isAlreadeyHave {
                continue
            } else {
                if type.checkIsItAchieved(challanges: challenges, phase: phase) {
                    newBadge = appCoreRepository.addBadge(for: type)
                    save()
                }
            }
        }
        
    }
    
    func addTodayMealRecord(name: String,
                            mealStatus: VitaChatAnswer,
                            timeStatus: VitaTimePhase,
                            photoName: String) {
        if let todayChallange = todayChallenge {
            appCoreRepository
                .addMealRecord(challange: todayChallange,
                               name: name, mealStatus: mealStatus,
                               timeStatus: timeStatus, photoName: photoName)
            save()
        } else {
            print("Error addMealRecordToTodayCallange todayChallange is NIL")
        }
    }
    
    func add66DaysOfChallanges() {
        let today = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: today)
        
        if hour >= 21 {
            self.isTomorrowStarting = true
            for challangeDay in 0..<66 {
                _ = appCoreRepository
                    .addChallenge(date: today.increaseDate(by: challangeDay+1)!,
                                  day: Int16(challangeDay+1))
            }
        } else {
            for challangeDay in 0..<66 {
                _ = appCoreRepository
                    .addChallenge(date: today.increaseDate(by: challangeDay)!,
                                  day: Int16(challangeDay+1))
            }
        }
        save()
    }
    
    func getVitaModel() {
        let countChallange = challenges.filter { ($0.records?.allObjects.count)! > 0 }.count
        
        if countChallange > 0 {
            let level = countChallange / 20
            if level >= 3 {
                vitaSkinModel = .white
            } else if level >= 2 {
                vitaSkinModel = .green
            } else if level >= 1 {
                vitaSkinModel = .orange
            } else {
                vitaSkinModel = .casual
            }
        }
    }
    
    func checkYesterdayHasNoRecord() -> Bool {
        let today = Date()
        let recordNilValue = -1
        let countRecordYesterday = challenges
            .filter { today.isDateYesterday($0.date) }
            .first?.records?.count ?? recordNilValue
        if countRecordYesterday == 0 {
            return true
        }
        return false
    }
    
    func levelProgress() -> Double {
        let countChallange = challenges.filter { ($0.records?.allObjects.count)! > 0 }.count
        if countChallange == 0 {return 0}
        let progress = Double(countChallange % 20)
        return progress == 0.0 ? 20.0 : progress
    }
    
    func countHowManyDaySinceStart() -> Int {
        let today = Date()
        return challenges.filter { (today.isItTodayOrPast(date: $0.date!)) }.count
    }
    
    func getChallangeBasedOnSection(section: Int) -> [ChallangeEntity] {
        if section == 2 {
            return challenges
                .filter {$0.day >= 45 && $0.day <= 66}.sorted { $0.day < $1.day }
        } else if section == 1 {
            return challenges
                .filter {$0.day >= 23 && $0.day <= 44}.sorted { $0.day < $1.day }
        } else {
            return challenges
                .filter {$0.day >= 1 && $0.day <= 22}.sorted { $0.day < $1.day }
        }
    }
    func getSectionBasedOnCurrentDay() -> Int {
        let today = Date()
        let currentDaysCount = challenges.filter { (today.isItTodayOrPast(date: $0.date!)) }.count
        if currentDaysCount >= 0 && currentDaysCount <= 22 {
            return 0
        } else if currentDaysCount >= 23 && currentDaysCount <= 44 {
            return 1
        } else {
            return 2
        }
    }
    
    func isAnotherTodayMealRecord() -> Bool {
        return (todayChallenge?.records!.count)! > 1
    }
    
    private func save() {
        appCoreRepository.save()
        fetchChallanges()
        fetchMealRecords()
        fetchBadges()
    }
}
