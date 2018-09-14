//
//  MetEventCommon.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/3/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
public class MetEventCommon: Codable {
    var appVersion: String?
    var keyClient: String?
    var deviceType: String?
    var deviceLanguage: String?
    var deviceId: String?
    var platform: String?
    
    public init() {}
}
