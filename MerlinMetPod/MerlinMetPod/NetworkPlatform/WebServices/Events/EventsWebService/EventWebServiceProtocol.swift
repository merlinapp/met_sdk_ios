//
//  EventWebServiceProtocol.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

enum EventResponse {
    case success
    case failure
}
typealias EventResponseClosure = (EventResponse) -> Void

protocol EventWebServiceProtocol {
    func sendEvent(completion: @escaping (EventResponseClosure))
}
