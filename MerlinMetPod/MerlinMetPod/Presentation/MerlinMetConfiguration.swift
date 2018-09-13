//
//  MerlinMetConfiguration.swift
//  MerlinMetPod
//
//  Created by Camila Gaitan Mosquera on 9/4/18.
//  Copyright © 2018 Camila Gaitan Mosquera. All rights reserved.
//

import Foundation

public class MerlinMetConfiguration: NSObject {
    
    private static var instance: MerlinMetConfiguration?
    static var shared: MerlinMetConfiguration {
        if instance == nil {
            instance = MerlinMetConfiguration()
        }
        return instance!
    }
    
    var URL: String = ""
    var totalBatchGroup: Int = 10
    
    override init() {
        super.init()
        setBatchTrigger()
    }
    
    public func initWithURL(URL: String) {
        self.URL = URL
        
    }
    
    public func track(_ event: [String: Any]) {
        
    }
    
    func setBatchTrigger() {
        RealmManager.shared.sendBatchEvents = {[weak self] () in
            guard let strongSelf = self else { return }
            
            strongSelf.sendBatchEvents()
        }
    }
    
    func sendBatchEvents() {
        let predicate = NSPredicate(format: "batchId == nil")
        let batchID = UUID().uuidString
        let eventsObject = RealmManager.shared.getAllWithPredicate(Class: RealmEvent.self, equalParam: predicate)
        let totalEventsToSend = eventsObject.count
        
        guard totalEventsToSend >= totalBatchGroup else {
            return
        }
        
        var arrayEvents: [Any] = []
        
        for _ in 0..<totalEventsToSend {
            let eventObject = eventsObject[0]
            RealmManager.shared.markWithBatchID(batchID, event: eventObject)
            
            if let stringEvent = eventObject.jsonString, let stringData: Data = stringEvent.data(using: .utf8) {
                var json: Any?
                do {
                    json = try JSONSerialization.jsonObject(with: stringData, options: .allowFragments) as? [String : Any]
                    arrayEvents.append(json!)
                } catch {
                    continue
                }
            }
        }
        
        var header: [String: Any] = [:]
        header["deviceType"] = "x86_64"
        header["platform"] = "iOS"
        header["deviceId"] = "90E14551-DC73-4193-A91B-2E18705ACCB0"
        header["appVersion"] = "2.0.8"
        header["events"] = arrayEvents
        header["keyClient"] = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhcGlLZXlDcmVhdGlvbiIsImFwaUtleSI6IjI2MEQ5NzREQjg0NDZGNkFFMjY0MTRDNjJFRjg3RkU3RERBQzQyMDg4Q0U2ODlDODU4MzY4QzhCQ0YxQjI1NkIiLCJwbGF0Zm9ybSI6ImlPUyJ9.nYTxvoxE00G-ic_CqiaZN4_HKltYpgI3tbd8fRqIzW0"
        let useCaseLocator = EventUserCaseLocator.eventLocator
        
        guard let useCase = useCaseLocator.getUserCase(ofType: SendEventProtocol.self) else { return }
        
        useCase.execute(eventObject: header) { (response) in
            print(response)
        }
        
        
    }
    
    func trackEvent() {
        let event = RealmEvent()
        event.id = UUID().uuidString
        event.jsonString = getMockEventString()
        RealmManager.shared.addObject(object: event)
    }
    
    private func getMockEventString() -> String {
        let stringEvent = """
                        {
                            "eventName": "view-job-preview",
                            "appsflyer": {
                                "idfa": "59A17311-87EB-4B66-B86A-823024F1FFB8",
                                "appsflyer_id": "1532430923817-9999896"
                            },
                            "idUser": "0d8c42fd-74b3-488a-8eac-1304ecbdb3a9",
                            "idEvent": "\(UUID().uuidString)",
                            "eventCategory": "candidate-jobs",
                            "userRole": "Candidate",
                            "idJob": "c1244c3a-926d-4597-9fae-ac6081746549",
                            "screenName": "Candidate_Search",
                            "idUserCandidate": "0d8c42fd-74b3-488a-8eac-1304ecbdb3a9",
                            "timeStamp": 1536680703.1561871,
                            "properties": {
                                "filter_applied": "true",
                                "screen_name": "Candidate_Search",
                                "filter_variant_radius": "Variant 1",
                                "event_category": "candidate-jobs",
                                "id_job_websafe": "agtzfm1lcmxpbi1xYXKNAQsSBFVzZXIiJGM2ZGYwYTJiLTBkMzctNDRjZS1iNGU3LTk5OWQxMmI1NGY0ZQwLEghFbXBsb3llciIkNTQ2ODRmODctOWRiMS00Njg0LTkwMWItNGNkZjQ5YjU5ZDQwDAsSA0pvYiIkYzEyNDRjM2EtOTI2ZC00NTk3LTlmYWUtYWM2MDgxNzQ2NTQ5DA",
                                "order": "1"
                            }
                        }
                        """
        return stringEvent
    }
}
