//
//  EnvironmentConfiguration.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 8/22/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

struct EnvironmentConstants {
static let EventEndpointKey = "event-url"
static let EnvironmentsKey = "EnvironmentConfiguration"
}

class EnvironmentConfiguration {
    var configurationPath: String!
    var servicesKeys: NSDictionary!
    static let sharedInstance = EnvironmentConfiguration()
    init() {
        let bundle = Bundle(for: type(of: self))
        self.configurationPath = bundle.infoDictionary!["Configuration"] as! String?
        let environmentPath = bundle.path(forResource: EnvironmentConstants.EnvironmentsKey, ofType: "plist")
        let configurationsDic = NSDictionary(contentsOfFile: environmentPath!)
        self.servicesKeys = (configurationsDic?.object(forKey: self.configurationPath.trimmingCharacters(in: CharacterSet.whitespaces))) as! NSDictionary?
    }
    /**
     
     This function returns the current build configuration of the project
     - Returns: a string variable with the configuration path
     
     */
    func configuration() -> String {
        return EnvironmentConfiguration.sharedInstance.configurationPath
    }
    /**
     
     This function returns the current APIEndpoint as general base URL
     
     - Returns:  a string variable with the URL for the Merlin API
     
     */
    func EventEndpoint() -> String? {
        let sharedConfiguration = EnvironmentConfiguration.sharedInstance
        let servicesKeysCount = sharedConfiguration.servicesKeys.allKeys.count
        if servicesKeysCount != 0 {
            return sharedConfiguration.servicesKeys.object(forKey: EnvironmentConstants.EventEndpointKey) as? String
        }
        return nil
    }
}
