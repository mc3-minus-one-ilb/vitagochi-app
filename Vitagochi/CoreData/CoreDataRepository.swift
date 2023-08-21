//
//  MealRecordRepository.swift
//  Vitagochi
//
//  Created by Enzu Ao on 21/07/23.
//

import Foundation
import CoreData

class CoreDataRepository {
    public static let singleton = CoreDataRepository(manager: CoreDataManager.instance)
    
    private let coreDataManager: CoreDataManager
    
    init(manager: CoreDataManager) {
        self.coreDataManager = manager
    }
    
    func getChallanges() -> [ChallangeEntity] {
        let request = NSFetchRequest<ChallangeEntity>(entityName: "ChallangeEntity")
        
        do {
            return try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching challange. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func getMealRecords() -> [MealRecordEntity] {
        let request = NSFetchRequest<MealRecordEntity>(entityName: "MealRecordEntity")
        
        do {
            return try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching mealRecord. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func getBadges() -> [BadgeEntity] {
        let request = NSFetchRequest<BadgeEntity>(entityName: "BadgeEntity")
        
        do {
            return try coreDataManager.context.fetch(request)
        } catch {
            print("Error fetching badge. \(error.localizedDescription)")
        }
        
        return []
    }
    
    func addBadge(for type: BadgeType) -> BadgeEntity {
        let newBadge = BadgeEntity(context: coreDataManager.context)
        newBadge.badgeId = type.rawValue
        newBadge.achievedDate = Date()
        return newBadge
    }
    
    func addChallenge(date: Date, day: Int16) -> ChallangeEntity {
        let newChallange = ChallangeEntity(context: coreDataManager.context)
        newChallange.date = date
        newChallange.day = day
        return newChallange
    }
    
    func addMealRecord(challange: ChallangeEntity,
                       name: String,
                       mealStatus: VitaChatAnswer,
                       timeStatus: VitaTimePhase,
                       photoName: String) {
        let newMealRecord = MealRecordEntity(context: coreDataManager.context)
        newMealRecord.mealStatus = mealStatus.rawValue
        newMealRecord.timeStatus = timeStatus.rawValue
        newMealRecord.photo = photoName
        newMealRecord.vitaMessage =  mealStatus.getAnswer(name: name)
        newMealRecord.challange = challange
        newMealRecord.time = Date()
        print(newMealRecord)
    }
    
    func save() {
        coreDataManager.save()
    }
}
