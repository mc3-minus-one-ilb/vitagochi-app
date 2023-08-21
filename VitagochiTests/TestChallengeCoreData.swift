//
//  TestChallengeCoreData.swift
//  VitagochiTests
//
//  Created by Enzu Ao on 20/08/23.
//

import XCTest
@testable import Vitagochi
import CoreData

final class TestChallengeCoreData: XCTestCase {
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
    
    func testAdd66DayChallenges() {
        XCTAssertEqual(coreDataEnv.challenges.count, 66)
    }
    
    func testSetTodayChallenge() {
        coreDataEnv.setTodayChallange()
        XCTAssertNotNil(coreDataEnv.todayChallenge)
    }
    
    func testMorningTaskBadges() {
        for index in 0...12 {
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
        for index in 0...22 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .afternoon,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .afternoon)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.energizeLunch.rawValue)
    }
    
    func testDinnerTimeDelightBadges() {
        for index in 0...22 {
            let today = Date()
            coreDataEnv.setTodayChallange(today.increaseDate(by: index) ?? today)
            coreDataEnv.addTodayMealRecord(name: "Tes",
                                           mealStatus: .exactly,
                                           timeStatus: .evening,
                                           photoName: "")
        }
        coreDataEnv.checkAndAddBadge(phase: .evening)
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.dinnertimeDelight.rawValue)
    }
    
    func testSunNoonBadges() {
        for index in 0...33 {
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
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.sunNoonFeast.rawValue)
    }
    
    func testTwilightBadges() {
        for index in 0...33 {
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
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.twilightTasting.rawValue)
    }
    
    func test3TimesMealsBadges() {
        for index in 0...44 {
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
        XCTAssertEqual(coreDataEnv.newBadge?.badgeId, BadgeType.meals3Times.rawValue)
    }
}
