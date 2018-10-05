//
//  MerlinTestConstants.swift
//  MerlinMetPodTests
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

struct MerlinTestConstants {
    
    struct General {
        static let urlTest = "met.url.com"
    }
    
    struct StatusCode {
        static let successCodeResponse = 200
        static let failureCodeResponse = 401
    }
    struct AssertsMessage {
        static let failureResponse = "The response should be a failure"
        static let successResponse = "The response should be success"
        static let equalValues = "The values should be equals"
        static let notNilValue = "The value not should be nil"
    }
}
