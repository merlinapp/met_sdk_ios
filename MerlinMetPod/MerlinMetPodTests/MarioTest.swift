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
//        RealmManager.shared.deleteAllObject(Class: RealmEvent.self)
        for _ in 0..<30 {
            MerlinMetConfiguration.shared.trackEvent()
        }
    
    }
    
    func testExample() {
        let predicate = NSPredicate(format: "batchId == nil")
        
        // Here we need put our entiti dictionary to send in service
        var eventEntitiesToSend: EventEntitiToSend! =  EventEntitiToSend()
        
        RealmManager.shared.sendBatchEvents = {
            let batchID = UUID().uuidString
            let eventsObject = RealmManager.shared.getAllWithPredicate(Class: RealmEvent.self, equalParam: predicate)
            
            guard eventsObject.count >= 30 else {
                return
            }
            
            for _ in 0..<30 {
                let eventObject = eventsObject[0]
                RealmManager.shared.markWithBatchID(batchID, event: eventObject)
//                let realm = try! Realm()
//                try! realm.write {
//                    event.batchId = batchID
//                    realm.add(event, update: true)
//                }
                // Add and transform realm object to our model
                let ourEntitiEvent = eventObject.jsonString
                // Now append in to array to send
                eventEntitiesToSend.events?.append(ourEntitiEvent!)
            }
            
            
            // IF Response is success we need delete the events
            RealmManager.shared.deleteWithPredicate(Class: RealmEvent.self, equalParam: NSPredicate(format: "batchId == %@", batchID))
            
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
