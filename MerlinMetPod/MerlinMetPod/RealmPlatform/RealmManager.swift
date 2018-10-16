    //
    //  RealmManager.swift
    //  MerlinMetPod
    //
    //  Created by Mario Acero on 9/5/18.
    //  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
    //
    
    import Foundation
    import RealmSwift
    
    class RealmManager {
        
        var realm: Realm!
        static let shared = RealmManager()
        var sendBatchEvents: (() -> Void)?
        var sendSingleEventNow: (() -> Void)?
        
        private func getRealmInstance() -> Realm? {
            do {
                let realmInstance = try Realm()
                return realmInstance
            } catch let error as NSError {
                assertionFailure("Somethig went wrong with Realm, error = \(error.description)")
            }
            return nil
        }
        init() {
            applyMigration()
            realm = getRealmInstance()!
        }
        func applyMigration() {
            let version = UInt64(truncating: MerlinMetConfiguration.shared.realmVersion)
            let config: Realm.Configuration = Realm.Configuration(inMemoryIdentifier:"identifier", schemaVersion: version ,  migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < version){
                    
                }
                
            })
            Realm.Configuration.defaultConfiguration = config
        }
        
        func getAll <T: Object> (Class: T.Type) -> Results<T> {
            var list: Results<T>? = nil
            list = realm.objects(Class)
            return list!
        }
        
        func getAllWithPredicate <T: Object> (Class: T.Type, equalParam: NSPredicate) -> Results<T> {
            realm = getRealmInstance()!
            var list: Results<T>? = nil
            list = realm.objects(Class).filter(equalParam)
            return list!
        }
        
        func markWithBatchID(_ batchID: String?, event: RealmEvent) {
            realm = getRealmInstance()!
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
            realm = getRealmInstance()!
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
            realm = getRealmInstance()!
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
            realm = getRealmInstance()!
            
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
            realm = getRealmInstance()!
            realm.beginWrite()
            realm.delete(value)
            try! realm.commitWrite()
        }
    }
