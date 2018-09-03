//
//  MetEventCommon.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/3/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
protocol MetEventCommon: Codable {
    var appVersion: String? { get set }
    var keyClient: String? { get set }
    var batchId: String? { get set }
    var deviceType: String? { get set }
    var deviceLanguage: String? { get set }
    var platform: String? { get set }
}
