//
//  MetEventProperiesTwo.swift
//  MerlinMetPod
//
//  Created by Mario Acero on 9/12/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

protocol MetEventProperiesTwo: Codable {
    var eventName: String? { get set }
    var appsflyer: [String: String]? { get set }
    var idUser: String? { get set }
    var idEvent: String? { get set }
    var eventCategory: String? { get set }
    var userRole: String? { get set }
    var idJob: String? { get set }
    var screenName: String? { get set }
    var idUserCandidate: String? { get set }
    var timestamp: Date? { get set }
    var properties: [String: String]? { get set }
}

struct RawMetEventProperiesTwo: MetEventProperiesTwo {
    var eventName: String?
    
    var appsflyer: [String: String ]?
    
    var idUser: String?
    
    var idEvent: String?
    
    var eventCategory: String?
    
    var userRole: String?
    
    var idJob: String?
    
    var screenName: String?
    
    var idUserCandidate: String?
    
    var timestamp: Date?
    
    var properties: [String: String ]?
    
    
}
