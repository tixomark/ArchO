//
//  CardPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import Foundation

protocol CardPresenterInput {
    
}

class CardPresenter {
    weak var view: CardPVCInput!
    
    
    deinit {
        print("deinit CardPresenter")
    }
}

extension CardPresenter: CardPresenterInput {
    
}
