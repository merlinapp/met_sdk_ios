//
//  SendEventUserCase.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

class SendEventUserCase: BaseUserCase, SendEventProtocol {
    func execute(eventObject: MetEvent, completion: @escaping EventResponseClosure) {
        if let currentRepo = repository as? EventRepository {
            currentRepo.sendEvent(eventObject: eventObject) { (response) in
                completion(response)
            }
        }
    }
}
