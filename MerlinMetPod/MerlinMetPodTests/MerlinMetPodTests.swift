//
//  MerlinMetPodTests.swift
//  MerlinMetPodTests
//
//  Created by Camila Gaitan Mosquera on 5/11/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import XCTest
import Moya
@testable import MerlinMetPod

class MerlinMetPodTests: XCTestCase {
    var jsonData = [String: Any]()
    override func setUp() {
        super.setUp()
        let testBundle = Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: "METRequest", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath!))
        jsonData = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
    }
    override func tearDown() {
        super.tearDown()
        jsonData = [:]
    }
    func testMETWithWrongData() {
        let expectation = XCTestExpectation(description: "MET with wrong data")
        let provider = MoyaProvider<EventsAPI>(stubClosure: { (_: EventsAPI) -> Moya.StubBehavior in return .immediate })
        provider.request(.createEventsBatch(parameters:["": ""])) { (result) in
            switch result {
            case let .success(moyaResponse):
                //TODO: We need to change this validation when Eric changes the service
                XCTAssertNotNil(moyaResponse.data)
            case let .failure(error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    func testMETWithRightData() {
        let expectation = XCTestExpectation(description: "MET with wrong data")
        let provider = MoyaProvider<EventsAPI>(stubClosure: { (_: EventsAPI) -> Moya.StubBehavior in return .immediate })
        provider.request(.createEventsBatch(parameters:["": jsonData])) { (result) in
            switch result {
            case let .success(moyaResponse):
                XCTAssertNotNil(moyaResponse.data)
            case let .failure(error):
                print(error.errorDescription ?? "Error with  the met events")
                XCTAssertNil(error)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
