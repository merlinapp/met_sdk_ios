//
//  WebServiceLocator.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

class WebServiceLocator {
    private static var instance: WebServiceLocator?
    static var sharedInstance: WebServiceLocator {
        if instance == nil {
            instance = WebServiceLocator()
        }
        return instance!
    }
    private init() {}
    func getWebService<T>(ofType type: T.Type) -> T? {
        switch String(describing: type) {
        case String(describing: EventWebServiceProtocol.self):
            return buildWebService(type: EventWebService.self)
        default:
            return nil
        }
    }
    private func buildWebService<U: BaseWebService, R>(type: U.Type) -> R? {
        return U() as? R
    }
}
