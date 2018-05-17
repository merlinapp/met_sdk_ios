//
//  EventsAPI.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 5/15/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import UIKit
import Moya

// MARK: - Provider setup
public let eventsEndpointClosure = { (target: EventsAPI) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    switch target {
    case .createEventsBatch:
        return defaultEndpoint
    }
}

// MARK: - Provider support
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum EventsAPI {
    case createEventsBatch(parameters:[String: Any])
}

extension EventsAPI: TargetType {
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    public var baseURL: URL {
        //TODO: Change this fake URL when I build the handler
        return URL(string: "https://us-central1-merlin-qa.cloudfunctions.net/")!
    }
    public var path: String {
        switch self {
        case .createEventsBatch:
            //TODO: Change this fake path when I build the handler
            return "eventTracker"
        }
    }
    public var method: Moya.Method {
        return .post
    }
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    public var task: Task {
        switch self {
        case .createEventsBatch(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    public var validate: Bool {
        switch self {
        case .createEventsBatch(_):
            return true
        }
    }
    public var sampleData: Data {
        switch self {
        case .createEventsBatch(_):
            return "{}".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
