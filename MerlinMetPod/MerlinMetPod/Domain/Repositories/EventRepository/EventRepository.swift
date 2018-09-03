//
//  EventRepository.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

class EventRepository: EventRepositoryProtocol {
    private var eventWebService: EventWebServiceProtocol
    init(webServiceLocator: WebServiceLocator) {
        let locator = webServiceLocator
        eventWebService = locator.getWebService(ofType: EventWebServiceProtocol.self)!
    }
    func sendEvent(eventObject: MetEvent, completion: @escaping EventResponseClosure) {
        eventWebService.sendEvent(eventObject: eventObject, completion: completion)
    }
}
