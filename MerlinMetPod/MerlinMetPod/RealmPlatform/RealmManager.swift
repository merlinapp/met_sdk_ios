//  RealmManager.swift
//  MerlinMetPod
//
//  Created by Mario Acero on 9/5/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.

import Foundation
import RealmSwift
    
class RealmManager {
        
        private var realm: Realm!
        private var config = Realm.Configuration()
        private static var instance: RealmManager?
        
        static var shared: RealmManager {
            if instance == nil {
                instance = RealmManager()
            }
            
            if instance!.realm == nil {
                do {
                    let realmInstance = try Realm.init(configuration: instance!.config)
                    instance!.realm = realmInstance
                } catch let error as NSError {
                    assertionFailure("Somethig went wrong with Realm, error = \(error.description)")
                }
            }
            return instance!
        }
        
        var sendBatchEvents: (() -> Void)?
        var sendSingleEventNow: (() -> Void)?
        
        init() {
            applyMigration()
        }
        func applyMigration() {
            
            if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
                config.inMemoryIdentifier = "test"
            } else {
                config = Realm.Configuration(inMemoryIdentifier: ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"],
                                             schemaVersion: UInt64(truncating: 0),
                                             objectTypes: [RealmEvent.self])
                config.fileURL = config.fileURL?.deletingLastPathComponent().appendingPathComponent("events.realm")
            }
        }
        
        func getAll <T: Object> (Class: T.Type) -> Results<T> {
            var list: Results<T>? = nil
            list = realm.objects(Class)
            return list!
        }
        
        func getAllWithPredicate <T: Object> (Class: T.Type, equalParam: NSPredicate) -> Results<T> {
            var list: Results<T>? = nil
            list = realm.objects(Class).filter(equalParam)
            return list!
        }
        
        func markWithBatchID(_ batchID: String?, event: RealmEvent) {
            do {
                try realm.write {
                    event.batchId = batchID
                    realm.add(event, update: true)
                }
            } catch let error as NSError {
                assertionFailure("Somethig went wrong with Realm (Write), error = \(error.description)")
            }
        }
        
        func addObject(object: Object, update: Bool = false) {
            do {
                try realm.write {
                    realm.add(object, update: update)
                }
            } catch let error as NSError {
                assertionFailure("Somethig went wrong with Realm (Write), error = \(error.description)")
            }
            
            if getAllWithPredicate(Class: RealmEvent.self, equalParam: NSPredicate(format: "batchId == nil")) .count >= MerlinMetConfiguration.shared.totalBatchGroup {
                sendBatchEvents?()
            }
            
        }
        
        func deleteWithPredicate <T: Object> (Class: T.Type, equalParam: NSPredicate) {
            realm.beginWrite()
            let realmResults = realm.objects(Class).filter(equalParam)
            if !realmResults.isEmpty {
                for object in realmResults {
                    self.realm.delete(object)
                }
            }
            try! realm.commitWrite()
        }
        
        func deleteAllObject <T: Object> (Class: T.Type) {
            let realmResults = realm.objects(Class)
            if(!realmResults.isEmpty) {
                for object in realmResults {
                    realm.beginWrite()
                    realm.delete(object)
                    try! realm.commitWrite()
                }
                
            }
            
        }
        
        func deleteSingleObject <T: Object> (Class: T.Type, value: Object) -> Void {
            realm.beginWrite()
            realm.delete(value)
            try! realm.commitWrite()
        }
}
