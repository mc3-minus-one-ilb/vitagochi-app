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
#if targetEnvironment(simulator)
        let coreDataManager = CoreDataManager(.inMemory)
        let coreDataRepository = CoreDataRepository(manager: coreDataManager)
        self.appCoreRepository = coreDataRepository
        fetchChallanges()
        fetchMealRecords()
        fetchBadges()
        if challenges.isEmpty {
            add66DaysOfChallanges()
        }
        setTodayChallange()
        getVitaModel()
#else
        self.appCoreRepository = repository
        fetchChallanges()
        fetchMealRecords()
        fetchBadges()
        if challenges.isEmpty {
            add66DaysOfChallanges()
        }
        setTodayChallange()
        getVitaModel()
#endif
        
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
        
        if hour >= VitaTimePhase.afterDay.time.hour {
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
    
    // MARK: Badges Section
    func checkAndAddBadge(phase: VitaTimePhase) {
        let badgesThatCanBeAchieved = badgesThatCanBeAchieved(phase: phase)
        for badge in badgesThatCanBeAchieved {
            if isBadgesAlreadyHave(badge: badge) {
                continue
            }
            if isBadgeAchieved(badge: badge) {
                newBadge = appCoreRepository.addBadge(for: badge)
                save()
            }
        }
    }
    
    private func isBadgeAchieved(badge: BadgeType) -> Bool {
        return countBadgesProgress(badge: badge) >= badge.daysToAchiveBadge
    }
    
    private func isBadgesAlreadyHave(badge: BadgeType) -> Bool {
        for accquiredBadge in badges
        where accquiredBadge.badgeId == badge.rawValue {
            return true
        }
        return false
    }
    
    private func badgesThatCanBeAchieved(phase: VitaTimePhase) -> [BadgeType] {
        switch phase {
        case.morning:
            return [BadgeType.morningTask]
        case.afternoon:
            return [BadgeType.happyLunch, BadgeType.doubleFeast]
        case.evening:
            return [BadgeType.delightDinner,
                    BadgeType.twilightTaste,
                    BadgeType.tripleMeals]
        case.beforeDayStart, .afterDay:
            return []
        }
    }
    
    func countBadgesProgress(badge: BadgeType) -> Int {
        switch badge {
        case.morningTask:
            let breakfast = challenges.filter { challenge in
                if let records = challenge.records?.allObjects as? [MealRecordEntity] {
                    if records.isEmpty {return false}
                    return records.contains { record in
                        record.timeStatus == VitaTimePhase.morning.rawValue
                    }
                }
                return false
            }.count
            return breakfast
        case.happyLunch:
            let lunch = challenges.filter { challenge in
                if let records = challenge.records?.allObjects as? [MealRecordEntity] {
                    if records.isEmpty {return false}
                    return records.contains { record in
                        record.timeStatus == VitaTimePhase.afternoon.rawValue
                    }
                }
                return false
            }.count
            return lunch
        case.delightDinner:
            let dinner = challenges.filter { challenge in
                if let records = challenge.records?.allObjects as? [MealRecordEntity] {
                    if records.isEmpty {return false}
                    return records.contains { record in
                        record.timeStatus == VitaTimePhase.evening.rawValue
                    }
                }
                return false
            }.count
            return dinner
        case.doubleFeast:
            let fastLunch = challenges.filter { challenge in
                if let records = challenge.records?.allObjects as? [MealRecordEntity] {
                    if records.count <= 1 {return false}
                    return records.contains { record in
                        record.timeStatus == VitaTimePhase.morning.rawValue
                    } && records.contains { record in
                        record.timeStatus == VitaTimePhase.afternoon.rawValue
                    }
                }
                return false
            }.count
            return fastLunch
        case.twilightTaste:
            let lunchDinner = challenges.filter { challenge in
                if let records = challenge.records?.allObjects as? [MealRecordEntity] {
                    if records.count <= 1 {return false}
                    return records.contains { record in
                        record.timeStatus == VitaTimePhase.afternoon.rawValue
                    } && records.contains { record in
                        record.timeStatus == VitaTimePhase.evening.rawValue
                    }
                }
                return false
            }.count
            return lunchDinner
        case.tripleMeals:
            let meals3 = challenges.filter { challenge in
                if let records = challenge.records?.allObjects as? [MealRecordEntity] {
                    return records.count >= 3
                }
                return false
            }.count
            return meals3
        }
    }
    
    private func save() {
        appCoreRepository.save()
        fetchChallanges()
        fetchMealRecords()
        fetchBadges()
    }
}
