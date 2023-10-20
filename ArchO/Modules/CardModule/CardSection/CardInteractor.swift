//
//  CardInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import Foundation

protocol CardInteractorInput {
    
}

extension CardInteractor: ServiceObtainable {
    var neededServices: [Service] {
        []
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        
    }
    
    
}

class CardInteractor {
    var presenter: CardPresenterInput!
    
//    var images: [UIImage] = []
    
    deinit {
        print("deinit CardInteractor")
    }
}

extension CardInteractor: CardInteractorInput {
    
}
