//
//  Service.swift
//  ArchO
//
//  Created by Tixon Markin on 30.06.2023.
//

import Foundation

enum Service {
    case network, datastore, auth, cardManager, userManager
}

protocol ServiceProtocol: CustomStringConvertible {
    
}

protocol ServiceObtainable {
    var neededServices: [Service] {get}
    func addServices(_ services: [Service: ServiceProtocol])
}

protocol ServiceDistributor {
    var serviceInjector: ServiceInjector? {get}
}
