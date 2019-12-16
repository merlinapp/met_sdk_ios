//
//  MerlinMetConfiguration.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/4/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

public class MerlinMetConfiguration: NSObject {
    
    public static var instance: MerlinMetConfiguration?
    public static var shared: MerlinMetConfiguration {
        if instance == nil {
            instance = MerlinMetConfiguration()
        }
        return instance!
    }
    
    var URL: String = ""

    var eventHeader: MetEventCommon?
    var totalBatchGroup: Int = 30
    
    // Use this properties only for UT propose
    var sendEventCustomClosureTest: EventCustomClosure?
    var closureForTestResponse: ((Bool)->())?
    
    override init() {
        super.init()
    }
    
    public func setup(URL: String, eventHeader: MetEventCommon) {
        self.URL = URL
        self.eventHeader = eventHeader
    }
    
    public func saveEvent(eventString: String) {
        let event = RealmEvent()
        event.id = UUID().uuidString
        event.jsonString = eventString
        RealmManager.shared.addObject(object: event)
    }
    
    public func getEvent(event: String) -> [String: Any] {
        
        var arrayEvents: [Any] = []
        var eventBody: MetEvent = [:]
        let stringData: Data = event.data(using: .utf8)!
        
        if !stringData.isEmpty {
            var json: Any?
            do {
                json = try JSONSerialization.jsonObject(with: stringData, options: .allowFragments) as? [String: Any]
                arrayEvents.append(json!)
                
                eventBody = getHeader()
                eventBody["events"] = arrayEvents
                
            } catch {
                print("Unexpected error: \(error)")
            }
        }
        
        return eventBody
    }
    
    public func eventsSubscriber() {
        RealmManager.shared.sendBatchEvents = {[weak self] () in
            guard let strongSelf = self else { return }
            
            strongSelf.sendBatchEvents(completion: nil)
        }
        
        RealmManager.shared.sendSingleEventNow = {[weak self] () in
            guard self != nil else { return }
            
        }
    }
    
    public func sendBatchEvents(completion: EventResponseClosure?) {
        let predicate = NSPredicate(format: "batchId == nil")
        let batchID = UUID().uuidString
        let eventsObjectToSend = RealmManager.shared.getAllWithPredicate(Class: RealmEvent.self, equalParam: predicate)
        let totalEventsToSend = eventsObjectToSend.count
        
        var arrayEvents: [Any] = []
        
        if totalEventsToSend == 0 {
            completion?(EventResponse.success)
            return
        }
        
        for _ in 0..<totalEventsToSend {
            let eventObject = eventsObjectToSend[0]
            RealmManager.shared.markWithBatchID(batchID, event: eventObject)
            
            if let stringEvent = eventObject.jsonString, let stringData: Data = stringEvent.data(using: .utf8) {
                var json: Any?
                do {
                    json = try JSONSerialization.jsonObject(with: stringData, options: .allowFragments) as? [String: Any]
                    arrayEvents.append(json!)
                } catch {
                    continue
                }
            }
        }
        
        let useCaseLocator = EventUserCaseLocator.eventLocator
        guard let useCase = useCaseLocator.getUserCase(ofType: SendEventProtocol.self) else { return }
        
        var header = getHeader()
        header["events"] = arrayEvents
        
        setTestClosureForSendEvent(useCase: useCase)
        
        useCase.execute(eventObject: header) { [weak self] (response) in
            guard let strongSelf = self else { return }
            
            let predicate = NSPredicate(format: "batchId == %@", batchID)
            
            switch response {
            case .success:
                RealmManager.shared.deleteWithPredicate(Class: RealmEvent.self, equalParam: predicate)
                strongSelf.closureForTestResponse?(true)
            case . failure:
                let eventsObjectFailure = RealmManager.shared.getAllWithPredicate(Class: RealmEvent.self, equalParam: predicate)
                for _ in 0..<eventsObjectFailure.count {
                    let eventObject = eventsObjectFailure[0]
                    RealmManager.shared.markWithBatchID(nil, event: eventObject)
                }
                strongSelf.closureForTestResponse?(false)
            }
            completion?(response)
        }
    }
    
    private func getHeader() -> MetEvent {
        var header: [String: Any] = [:]
        header["deviceType"] = eventHeader?.deviceType
        header["deviceLanguage"] = eventHeader?.deviceLanguage
        header["platform"] = eventHeader?.platform
        header["deviceId"] = eventHeader?.deviceId
        header["appVersion"] = eventHeader?.appVersion
        header["keyClient"] = eventHeader?.keyClient
        return header
    }
    
     private func setTestClosureForSendEvent(useCase: SendEventProtocol) {
        if let customClosure = sendEventCustomClosureTest,
            let useCaseSendEvent = useCase as? SendEventUserCase,
            let repo = useCaseSendEvent.repository as? EventRepository,
            let webServ = repo.eventWebService as? EventWebService {
            
            webServ.networkProvider = EventNetworkProvider.init(customClosure: customClosure)
        }
    }
}
