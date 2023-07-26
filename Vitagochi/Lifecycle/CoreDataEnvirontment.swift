//
//  CoreDataViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 20/07/23.
//

import SwiftUI
import CoreData

class CoreDataEnvirontment: ObservableObject {
    public static let singleton: CoreDataEnvirontment = CoreDataEnvirontment()
    private let appCoreRepository: CoreDataRepository = CoreDataRepository.singleton
    @Published var challanges: [ChallangeEntity] = []
    @Published var mealRecords: [MealRecordEntity] = []
    @Published var todayChallange: ChallangeEntity?
    @Published var vitaSkinModel: VitaSkinModel = .casual
    
    init() {
        fetchChallanges()
        fetchMealRecords()
        if challanges.count > 0 {
            getTodayChallange()
            //            getVitaModel()
        }
        if challanges.count == 0 {
            add66DaysOfChallanges()
        }
    }
    
    func fetchChallanges() {
        challanges = appCoreRepository.getChallanges()
    }
    
    func fetchMealRecords() {
        mealRecords = appCoreRepository.getMealRecords()
    }
    
    func getTodayCompletedChallange() -> Int {
        return todayChallange?.records?.count ?? 0
    }
    
    func getTodayChallange() {
        let today = Date()
        var i = 1
        for challange in challanges {
            if let challangeDate = challange.date, today.isItToday(date: challangeDate){
                todayChallange = challange
                return
            } else {
                i+=1
            }
        }
        if todayChallange == nil {
            appCoreRepository.addChallange(date: Date(), day: Int16(i))
            save()
            todayChallange = challanges.last
        }
    }
    
    func addMealRecordToTodayCallange(name: String,
                                      mealStatus: VitaMessageAnswer,
                                      timeStatus: VitachiTimePhase,
                                      photoName: String) {
        if let todayChallange = todayChallange {
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
        if challanges.count == 0 {
            let today = Date()
            for i in 0..<66 {
                appCoreRepository.addChallange(date: today.increaseDate(by: i)!, day: Int16(i+1))
            }
            save()
        }
    }
    
    func getVitaModel() {
        let countChallange = challanges.filter{ ($0.records?.allObjects.count)! > 0 }.count
        
        if countChallange % 20 == 0 && countChallange > 0 {
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
        let countRecordYesterday = challanges.filter { today.isDateYesterday($0.date) }.first?.records?.count ?? 0
        if countRecordYesterday == 0 {
            return true
        }
        return false
    }
    func levelProgress() -> Double {
        let countChallange = challanges.filter{ ($0.records?.allObjects.count)! > 0 }.count
        if countChallange == 0 {return 0}
        let progress = Double(countChallange % 20)
        return progress == 0.0 ? 20.0 : progress
    }
    
    func countHowManyDaySinceStart() -> Int {
        let today = Date()
        return challanges.filter{ (today.isItTodayOrPast(date: $0.date!)) }.count
    }
    
    func getChallangeBasedOnSection(section: Int) -> [ChallangeEntity] {
        if section == 2{
            return challanges.filter{$0.day >= 45 && $0.day <= 66}.sorted{ $0.day < $1.day }
        } else if section == 1{
            return challanges.filter{$0.day >= 23 && $0.day <= 44}.sorted{ $0.day < $1.day }
        } else {
            return challanges.filter{$0.day >= 1 && $0.day <= 22}.sorted{ $0.day < $1.day }
        }
    }
    
    
    func isAnotherTodayMealRecord() -> Bool {
        return (todayChallange?.records!.count)! > 1
    }
    
    func save() {
        appCoreRepository.save()
        fetchChallanges()
        fetchMealRecords()
    }
}
