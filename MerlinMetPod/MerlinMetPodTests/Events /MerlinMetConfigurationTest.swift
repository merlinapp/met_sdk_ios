//
//  MerlinMetConfigurationTest.swift
//  MerlinMetPodTests
//
//  Created by Mario Acero on 10/4/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import XCTest
import RealmSwift
@testable import MerlinMetPod

class MerlinMetConfigurationTest: XCTestCase {
    
    var merlinMet: MerlinMetConfiguration?
    
    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
        merlinMet = MerlinMetConfiguration.shared
    }

    override func tearDown() {
        merlinMet = nil
        RealmManager.shared.deleteAllObject(Class: RealmEvent.self)
    }

    func testSetup() {
        let url = MerlinTestConstants.General.urlTest
        let eventCommon = MetEventCommon()
        eventCommon.appVersion = "1.0.0"
        eventCommon.deviceId = UUID().uuidString
        eventCommon.deviceLanguage = "en"
        eventCommon.deviceType = "iPhone"
        eventCommon.keyClient = UUID().uuidString
        eventCommon.platform = "iOS"
        merlinMet?.setup(URL: url, eventHeader: eventCommon)
        
        XCTAssertEqual(merlinMet?.URL, url, MerlinTestConstants.AssertsMessage.equalValues)
        XCTAssertNotNil(merlinMet?.eventHeader, MerlinTestConstants.AssertsMessage.notNilValue)
    }
    
    func testSaveEvent() {
        let eventString = getMockDataEvent()
        merlinMet?.saveEvent(eventString: eventString)
        let events = RealmManager.shared.getAll(Class: RealmEvent.self)
        XCTAssertGreaterThan(events.count, 0)
    }
    
    func testGetEvent() {
        let eventString = getMockDataEvent()
        let eventJson: [String: Any]? = merlinMet?.getEvent(event: eventString)
        let eventBody = eventJson?["events"]
        XCTAssertNotNil(eventBody, MerlinTestConstants.AssertsMessage.notNilValue)
    }
    
    func testSendBatchEventsSuccess() {
        let expectation = XCTestExpectation(description: "Send event Expectation")
        merlinMet?.totalBatchGroup = 1
        merlinMet?.eventsSubscriber()
        let url = MerlinTestConstants.General.urlTest
        let eventCommon = MetEventCommon()
        eventCommon.appVersion = "1.0.0"
        eventCommon.deviceId = UUID().uuidString
        eventCommon.deviceLanguage = "en"
        eventCommon.deviceType = "iPhone"
        eventCommon.keyClient = UUID().uuidString
        eventCommon.platform = "iOS"
        merlinMet?.setup(URL: url, eventHeader: eventCommon)
        
        let customClosure = CustomClosureBuilder.eventClosure(
            statusCode: MerlinTestConstants.StatusCode.successCodeResponse,
            isSuccess: true)
        merlinMet?.sendEventCustomClosureTest = customClosure
        
        merlinMet?.closureForTestResponse = { (isSuccess) in
            if isSuccess {
                let events = RealmManager.shared.getAll(Class: RealmEvent.self)
                XCTAssertEqual(events.count, 0, "The values should be zero")
                expectation.fulfill()
                return
            }
            
            XCTAssert(false, MerlinTestConstants.AssertsMessage.successResponse)
            expectation.fulfill()
        }
        let eventString = getMockDataEvent()
        merlinMet?.saveEvent(eventString: eventString)
        wait(for: [expectation], timeout: 60.0)
        
    }
    
    func testSendBatchEventsFailure() {
        let expectation = XCTestExpectation(description: "Send event Expectation")
        merlinMet?.totalBatchGroup = 1
        merlinMet?.eventsSubscriber()
        let url = "met.url.com"
        let eventCommon = MetEventCommon()
        eventCommon.appVersion = "1.0.0"
        eventCommon.deviceId = UUID().uuidString
        eventCommon.deviceLanguage = "en"
        eventCommon.deviceType = "iPhone"
        eventCommon.keyClient = UUID().uuidString
        eventCommon.platform = "iOS"
        merlinMet?.setup(URL: url, eventHeader: eventCommon)
        
        let customClosure = CustomClosureBuilder.eventClosure(
            statusCode: MerlinTestConstants.StatusCode.failureCodeResponse,
            isSuccess: false)
        merlinMet?.sendEventCustomClosureTest = customClosure
        
        merlinMet?.closureForTestResponse = { (isSuccess) in
            if !isSuccess {
                let events = RealmManager.shared.getAll(Class: RealmEvent.self)
                XCTAssertEqual(events.count, 1, "The values should be One")
                expectation.fulfill()
                return
            }
            
            XCTAssert(false, MerlinTestConstants.AssertsMessage.failureResponse)
            expectation.fulfill()
        }
        let eventString = getMockDataEvent()
        merlinMet?.saveEvent(eventString: eventString)
        wait(for: [expectation], timeout: 60.0)
        
    }
}

fileprivate extension MerlinMetConfigurationTest {
    
    func getMockDataEvent() -> String {
        let fileName = "singleEvent"
        let txtFile = "json"
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: fileName, ofType: txtFile)!
        return try! String(contentsOfFile: path)
    }

}
