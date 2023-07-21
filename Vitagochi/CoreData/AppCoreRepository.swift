//
//  CoreDataViewModel.swift
//  Vitagochi
//
//  Created by Enzu Ao on 20/07/23.
//

import SwiftUI
import CoreData

class AppCoreRepo: ObservableObject {
    let manager = CoreDataManager.instance
    @Published var challanges: [ChallangeEntity] = []
    @Published var mealRecords: [MealRecordEntity] = []
    @Published var todayChallange: ChallangeEntity?
    
    init() {
        getChallanges()
        getMealRecords()
        
        if challanges.count == 0 {
            let today = Date()
            for i in 0..<66 {
                addChallange(date: today.increaseDate(by: i)!, day: Int16(i+1))
            }
            save()
            getTodayChallange()
        } else {
            getTodayChallange()
        }
    }
    
    func getChallanges() {
        let request = NSFetchRequest<ChallangeEntity>(entityName: "ChallangeEntity")
        
        do {
            challanges = try manager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func getMealRecords() {
        let request = NSFetchRequest<MealRecordEntity>(entityName: "MealRecordEntity")
        
        do {
            mealRecords = try manager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
    }
    
    func addChallange(date: Date, day: Int16) {
        let newChallange = ChallangeEntity(context: manager.context)
        newChallange.date = date
        newChallange.day = day
        print(newChallange)
    }
    
    func addMealRecord(challange: ChallangeEntity,
                       mealStatus: VitaMessageAnswer,
                       timeStatus: VitachiTimePhase,
                       photoURI: URL) {
        let newMealRecord = MealRecordEntity(context: manager.context)
        newMealRecord.mealStatus = mealStatus.rawValue
        newMealRecord.timeStatus = timeStatus.rawValue
        newMealRecord.photo = photoURI
        newMealRecord.vitaMessage =  mealStatus.answer
        newMealRecord.challange = challange
        save()
    }
    
    func getTodayCompletedChallange() -> Int {
        return todayChallange?.records?.count ?? 0
    }
    
    func getTodayChallange() {
        let today = Date()
        for challange in challanges {
            if let challangeDate = challange.date {
                if today.isItToday(date: challangeDate) {
                    todayChallange = challange
                }
            }
        }
    }
    
    func save() {
        manager.save()
        getChallanges()
        getMealRecords()
    }
}
