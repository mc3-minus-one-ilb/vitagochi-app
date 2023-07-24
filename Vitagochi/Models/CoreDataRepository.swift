//
//  MealRecordRepository.swift
//  Vitagochi
//
//  Created by Enzu Ao on 21/07/23.
//

import Foundation
import CoreData

class CoreDataRepository {
    public static let singleton: CoreDataRepository = CoreDataRepository(manager: CoreDataManager.instance)
    
    private let coreDataManager: CoreDataManager
    
    init(manager: CoreDataManager) {
        self.coreDataManager = manager
    }
    
    func getChallanges() -> [ChallangeEntity] {
        let request = NSFetchRequest<ChallangeEntity>(entityName: "ChallangeEntity")
        
        do {
            return try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func getMealRecords() -> [MealRecordEntity] {
        let request = NSFetchRequest<MealRecordEntity>(entityName: "MealRecordEntity")
        
        do {
            return try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func addChallange(date: Date, day: Int16) {
        let newChallange = ChallangeEntity(context: coreDataManager.context)
        newChallange.date = date
        newChallange.day = day
    }
    
    func addMealRecord(challange: ChallangeEntity,
                       name: String,
                       mealStatus: VitaMessageAnswer,
                       timeStatus: VitachiTimePhase,
                       photoName: String) {
        let newMealRecord = MealRecordEntity(context: coreDataManager.context)
        newMealRecord.mealStatus = mealStatus.rawValue
        newMealRecord.timeStatus = timeStatus.rawValue
        newMealRecord.photo = photoName
        newMealRecord.vitaMessage =  mealStatus.answer(name: name)
        newMealRecord.challange = challange
        newMealRecord.time = Date()
        print(newMealRecord)
    }
    
    func save() {
        coreDataManager.save()
    }
}
