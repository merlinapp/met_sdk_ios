//
//  MerlinMetConfiguration.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/4/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

public class MerlinMetConfiguration: NSObject {
    
    private static var instance: MerlinMetConfiguration?
    static var shared: MerlinMetConfiguration {
        if instance == nil {
            instance = MerlinMetConfiguration()
        }
        return instance!
    }
    
    var URL: String = ""
    var totalBatchGroup: Int = 30
    
    override init() {
        super.init()
//        setBatchTrigger()
    }
    
    public func initWithURL(URL: String) {
        self.URL = URL
        
    }
    
    public func saveEvent(_ event: String ) {
        
        let a = RealmEvent()
        a.id = UUID().uuidString
        a.jsonString = event
        RealmManager.shared.addObject(object: a)
        let get = RealmManager.shared.getAll(Class: RealmEvent.self)
        print(get)
    }
    
    private func setBatchTrigger() {
        RealmManager.shared.sendBatchEvents = {[weak self] () in
            guard let strongSelf = self else { return }
            
            strongSelf.sendBatchEvents()
        }
    }
    
    private func sendBatchEvents() {
        _ = RealmManager.shared.getAll(Class: RealmEvent.self)
        for i in 0..<totalBatchGroup {
            print(i)
        }
        
    }
}
