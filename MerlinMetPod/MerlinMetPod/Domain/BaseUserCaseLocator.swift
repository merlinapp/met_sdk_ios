//
//  BaseUserCaseLocator.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/26/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

protocol BaseUserCaseLocatorProtocol {
    func getUserCase<T>(ofType type: T.Type) -> T?
}
