//
//  MetEventProperties.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/3/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

public protocol MetEventProperties: Codable {
    var eventName: String? { get set }
    var screenName: String? { get set }
    var idEvent: String? { get set }
    var idJob: String? { get set }
    var idUser: String? { get set }
    var idUserCandidate: String? { get set }
    var idUserEmployer: String? { get set }
    var userRole: String? { get set }
    var timestamp: Date? { get set }
    var properties: Dictionary<String, Any>? { get set }
}
