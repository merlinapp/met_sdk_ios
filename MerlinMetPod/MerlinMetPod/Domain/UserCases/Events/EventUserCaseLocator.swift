//
//  EventUserCaseLocator.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

class EventUserCaseLocator: BaseUserCaseLocatorProtocol {
    static let eventLocator = EventUserCaseLocator(repository: EventRepository(webServiceLocator: WebServiceLocator.sharedInstance))
    fileprivate let repository: Repository
    init(repository: Repository) {
        self.repository = repository
    }
    func getUserCase<T>(ofType type: T.Type) -> T? {
        switch String(describing: type) {
        case String(describing: send.self):
            return buildUseCase(type: SendEventUserCase.self)
        default:
            return nil
        }
    }
    private func buildUseCase<U: BaseUserCase, R>(type: U.Type) -> R? {
        return U(repository: repository) as? R
    }
}
