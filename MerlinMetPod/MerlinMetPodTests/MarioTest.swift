//
//  MarioTest.swift
//  MerlinMetPodTests
//
//  Created by Mario Acero on 9/5/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import XCTest
import RealmSwift

@testable import MerlinMetPod

class MarioTest: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        RealmManager.shared.deleteAllObject(Class: RealmEvent.self)
        super.tearDown()
    }
    
    func testMerlinConf() {
//        let expectation = XCTestExpectation(description: "Expect")
        RealmManager.shared.deleteAllObject(Class: RealmEvent.self)
        
//        RealmManager.shared.expectationFinish = {
//            XCTAssert(true)
//            expectation.fulfill()
//        }
//        
//        for _ in 0..<30 {
//            MerlinMetConfiguration.shared.trackEvent()
//        }
//        wait(for: [expectation], timeout: 60.0)
    }
}
