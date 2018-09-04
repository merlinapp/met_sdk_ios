//
//  MerlinMetConfiguration.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/4/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

public class MerlinMetConfiguration: NSObject {
    static let shared: MerlinMetConfiguration = MerlinMetConfiguration()
    var URL: String = ""
    override init() {
        super.init()
    }
    public func initWithURL(URL: String) {
        self.URL = URL
    }
}
