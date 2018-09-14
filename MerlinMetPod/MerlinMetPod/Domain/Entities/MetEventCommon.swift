//
//  MetEventCommon.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/3/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
public class MetEventCommon: Codable {
    public var appVersion: String?
    public var keyClient: String?
    public var deviceType: String?
    public var deviceLanguage: String?
    public var deviceId: String?
    public var platform: String?
    
    public init() {}
}
