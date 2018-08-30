//
//  Network.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation
import Moya

enum ApiServiceResponse {
    case failure(error: Any?)
    case notConnectedToInternet
    case success(response: Any?)
}

typealias ApiServiceResponseClosure = (ApiServiceResponse) -> Void

protocol Network {
    associatedtype MoyaType: TargetType
    var provider: MoyaProvider<MoyaType> { get }
}
