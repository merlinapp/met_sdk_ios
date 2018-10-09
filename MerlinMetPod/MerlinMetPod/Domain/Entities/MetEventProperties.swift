//
//  MetEventProperties.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/3/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

public class MetEventProperties: Codable {
    public var eventName: String?
    public var eventCategory: String?
    public var screenName: String?
    public var userRole: String?
    public var idEvent: String?
    public var idUser: String?
    public var idJob: String?
    public var idUserEmployer: String?
    public var idUserCandidate: String?
    public var appsflyer: Dictionary<String,String>?
    public var timeStamp: Double?
    public var properties: Dictionary<String,String>?
    
    public init() {}
}
