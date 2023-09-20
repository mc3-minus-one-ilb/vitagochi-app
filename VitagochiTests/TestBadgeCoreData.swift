//
//  TestBadgeCoreData.swift
//  VitagochiTests
//
//  Created by Enzu Ao on 21/08/23.
//

import XCTest
@testable import Vitagochi

final class TestBadgeCoreData: XCTestCase {
    var coreDataEnv: CoreDataEnvirontment!
    var coreDataManager: CoreDataManager!
    var coreDataRepository: CoreDataRepository!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager(.inMemory)
        coreDataRepository = CoreDataRepository(manager: coreDataManager)
        coreDataEnv = CoreDataEnvirontment(repository: coreDataRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataEnv = nil
        coreDataRepository = nil
        coreDataManager = nil
    }
    
    func testBadgesWholeScenario_shouldGetAppropriateBadgeID() {
        for index in 0...11 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .morning)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.morningTask.rawValue)
        XCTAssertEqual(coreDataEnv.badges.count, 1)
        
        for index in 12...21 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .afternoon)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.happyLunch.rawValue)
        XCTAssertEqual(coreDataEnv.badges.count, 2)
        
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.delightDinner.rawValue)
        XCTAssertEqual(coreDataEnv.badges.count, 3)
        
        for index in 22...32 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        
        coreDataEnv.checkAndAddBadge(phase: .afternoon)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.doubleFeast.rawValue)
        XCTAssertEqual(coreDataEnv.badges.count, 4)
        
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.twilightTaste.rawValue)
        XCTAssertEqual(coreDataEnv.badges.count, 5)
        
        for index in 33...43 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.tripleMeals.rawValue)
        XCTAssertEqual(coreDataEnv.badges.count, 6)
    }

    func testMorningTaskBadges() {
        for index in 0...11 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .morning)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.morningTask.rawValue)
    }
    
    func testEnergizeLunchBadges() {
        for index in 0...21 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .afternoon)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.happyLunch.rawValue)
    }
    
    func testDinnerTimeDelightBadges() {
        for index in 0...21 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.delightDinner.rawValue)
    }
    
    func testSunNoonBadges() {
        for index in 0...32 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .afternoon)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.doubleFeast.rawValue)
    }
    
    func testTwilightBadges() {
        for index in 0...32 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.twilightTaste.rawValue)
    }
    
    func test3TimesMealsBadges() {
        for index in 0...43 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .morning,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.tripleMeals.rawValue)
    }

}
