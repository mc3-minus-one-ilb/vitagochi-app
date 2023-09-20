//
//  TestChallengeCoreData.swift
//  VitagochiTests
//
//  Created by Enzu Ao on 20/08/23.
//

import XCTest
@testable import Vitagochi

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
    
    func testAdd66DayChallenges_maximumChallengesNumberShould() {
        XCTAssertEqual(coreDataEnv.challenges.count, 66)
    }
    
    func testSetTodayChallenge_shouldNotBeNil() {
        XCTAssertNotNil(coreDataEnv.todayChallenge)
    }
}
