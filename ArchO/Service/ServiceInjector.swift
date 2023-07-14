//
//  ServiceInjector.swift
//  ArchO
//
//  Created by Tixon Markin on 30.06.2023.
//

import Foundation

class ServiceInjector {
    var services: [Service:ServiceProtocol] = [:]
    
    init() {
        services[.datastore] = DataStore()
        services[.auth] = FBAuth()
        services[.firestore] = FirestoreDB()
    }
    
    func injectServices(forObject object: ServiceObtainable) {
        let neededServices = object.neededServices
        var servicesDict: [Service:ServiceProtocol] = [:]
        neededServices.forEach { service in
            servicesDict[service] = self.services[service]
        }
        object.addServices(servicesDict)
    }
}
