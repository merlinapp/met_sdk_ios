//
//  EventWebService.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

class EventWebService: BaseWebService, EventWebServiceProtocol {
    var networkProvider: EventNetworkProvider
    
    init?(eventCustomClosure: EventCustomClosure? = nil) {
        if let customClosure = eventCustomClosure {
            self.networkProvider = EventNetworkProvider(customClosure: customClosure)
            return
        }
        self.networkProvider = EventNetworkProvider()
    }
    required init() {
        self.networkProvider = EventNetworkProvider()
    }
    func sendEvent(eventObject: MetEvent, completion: @escaping (EventResponseClosure)) {
        networkProvider.sendRequest(eventObject: eventObject) { (response) in
            switch response {
            case .success(_) :
                completion(.success)
            default:
                completion(.failure)
            }
        }
    }
}
