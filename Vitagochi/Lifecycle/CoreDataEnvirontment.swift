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
    
    init() {
        fetchChallanges()
        fetchMealRecords()
        if challanges.count > 0 {
            getTodayChallange()
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
    
    func addMealRecordToTodayCallange(mealStatus: VitaMessageAnswer,
                                      timeStatus: VitachiTimePhase,
                                      photoURI: URL) {
        if let todayChallange = todayChallange {
            appCoreRepository.addMealRecord(challange: todayChallange, mealStatus: mealStatus, timeStatus: timeStatus, photoURI: photoURI)
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
    
    func save() {
        appCoreRepository.save()
        fetchChallanges()
        fetchMealRecords()
    }
}
