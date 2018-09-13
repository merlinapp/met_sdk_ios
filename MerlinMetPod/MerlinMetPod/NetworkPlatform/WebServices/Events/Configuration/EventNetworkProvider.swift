//
//  EventNetworkProvider.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
import Moya

typealias EventCustomClosure = (EventAPI) -> Endpoint

class EventNetworkProvider: Network {
    var provider: MoyaProvider<EventAPI>
    required init(customClosure: EventCustomClosure? = nil) {
        if customClosure == nil {
            provider = MoyaProvider<EventAPI> (plugins: [NetworkLoggerPlugin(verbose: true)])
            return
        }
        provider = MoyaProvider<EventAPI>(endpointClosure: customClosure!, stubClosure: MoyaProvider.immediatelyStub)
    }
    func sendRequest(eventObject: MetEvent, completion: @escaping (ApiServiceResponse) -> Void) {
        provider.request(.sendEvent(event: eventObject)) { (result) in
            switch result {
            case .success(_):
                completion(.success(response: []) )
            case .failure(_):
                completion(.failure(error: []))
            }
        }
    }
}
