//
//  RealmEvents.swift
//  MerlinMetPod
//
//  Created by Mario Acero on 9/5/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEvent: Object {
    
    @objc dynamic var id: String?
    @objc dynamic var jsonString: String?
    @objc dynamic var batchId: String?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
