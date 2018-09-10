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
//        RealmManager.shared.deleteAllObject(Class: RealmEvent.self)
        super.tearDown()
    }
    
    func testExample() {
        let predicate = NSPredicate(format: "batchId == nil")
        
        // Here we need put our entiti dictionary to send in service
        var eventEntitiesToSend: EventEntitiToSend! =  EventEntitiToSend()
        
        RealmManager.shared.sendBatchEvents = {
            let batchID = UUID().uuidString
            let eventsObject = RealmManager.shared.getAllWithPredicate(Class: RealmEvent.self, equalParam: predicate)
            
//            for index in 0..<30 {
//                let event = eventsObject[index]
//                event.batchId = batchID
//                RealmManager.shared.addObject(object: event, update: true)
//                
//                // Add and transform realm object to our model
//                let ourEntitiEvent = event.jsonString
//                // Now append in to array to send
//                eventEntitiesToSend.events?.append(ourEntitiEvent!)
//            }
            
            // IF Response is success we need delete the events
            // RealmManager.shared.deleteWithPredicate(Class: RealmEvent.self, equalParam: NSPredicate(format: "id == %@", eventEntitiesToSend))
            
            // IF Response is Failure we need remove batchID
            
        }
        
        for i in 0..<70 {
            let a = RealmEvent()
            a.id = UUID().uuidString
            a.jsonString = "Json string \(i)"
            RealmManager.shared.addObject(object: a)
        }
        let get = RealmManager.shared.getAll(Class: RealmEvent.self)
        print(get)
        XCTAssert(true)
    }
}
