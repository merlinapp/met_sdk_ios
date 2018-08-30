//
//  FlushEventWebServiceTest.swift
//  MerlinMetPodTests
//
//  Created by Camila Gaitan Mosquera on 8/30/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import XCTest

class FlushEventWebServiceTest: XCTestCase {
    var webService: EventWebService?
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        webService = nil
        super.tearDown()
    }
    func testFlushEventFailureResponse() {
        let expectation = XCTestExpectation(description: EventTestConstants.Expectations.sendEventFailureExpectation)
        let failureClosure = CustomClosureBuilder.eventClosure(statusCode: MerlinTestConstants.StatusCode.failureCodeResponse, isSuccess: false)
        webService = EventWebService(eventCustomClosure: failureClosure)
        webService?.sendEvent(completion: { (response) in
            switch response {
            case .success:
                XCTFail(MerlinTestConstants.AssertsMessage.failureResponse)
            case .failure:
                XCTAssert(true)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
    func testFlushEventSuccessResponse() {
        let expectation = XCTestExpectation(description: EventTestConstants.Expectations.sendEventSuccessExpectation)
        let successClosure = CustomClosureBuilder.eventClosure(statusCode: MerlinTestConstants.StatusCode.successCodeResponse, isSuccess: false)
        webService = EventWebService(eventCustomClosure: successClosure)
        webService?.sendEvent(completion: { (response) in
            switch response {
            case .success:
                XCTFail(MerlinTestConstants.AssertsMessage.successResponse)
            case .failure:
                XCTAssert(true)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1.0)
    }
}
