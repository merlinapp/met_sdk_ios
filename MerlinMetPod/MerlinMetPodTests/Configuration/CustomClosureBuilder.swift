//
//  CustomClosureBuilder.swift
//  MerlinMetPodTests
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
import Moya
@testable import MerlinMetPod

class CustomClosureBuilder: NSObject {
    static func eventClosure(statusCode: Int, isSuccess: Bool) -> EventCustomClosure {
        let customClosure = { (target: EventAPI) -> Endpoint in
            var sampleData: Data = target.sampleData
            if !isSuccess {
                sampleData = target.failureData
            }
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(statusCode, sampleData ) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        return customClosure
}
}
