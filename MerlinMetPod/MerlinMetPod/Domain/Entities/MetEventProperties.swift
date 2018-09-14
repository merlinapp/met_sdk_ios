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
    public var screenName: String?
    public var idEvent: String?
    public var idUser: String?
    public var timestamp: String?
    public var properties: Dictionary<String,String>?
    
    public init() {}
}
