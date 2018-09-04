//
//  EventAPI.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//
import Foundation
import Alamofire
import Moya

enum EventAPI {
    case sendEvent(eventObject: MetEvent)
}

extension EventAPI: TargetType {
    var baseURL: URL {
        guard let url = URL(string: MerlinMetConfiguration.shared.URL)
            else { fatalError("baseURL could not be configured.")}
        return url
    }
    var path: String {
        switch self {
        case .sendEvent( _):
            return ""
        }
    }
    var method: Moya.Method {
        return .post
    }
    var sampleData: Data {
        switch self {
        case .sendEvent( _):
            return "{success data }".data(using: String.Encoding.utf8)!
        }
    }
    var failureData: Data {
        switch self {
        case .sendEvent(_):
            return "{failure data test}".data(using: String.Encoding.utf8)!
        }
    }
    var task: Task {
        switch self {
        case .sendEvent :
            return .requestParameters(parameters: ["deviceId": ""], encoding: JSONEncoding.default)
        }
    }
    var headers: [String: String]? {
        return [:]
    }
    var validationType: ValidationType {
        return .successCodes
    }
}
