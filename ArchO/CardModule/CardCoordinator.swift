//
//  CardsCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol CardCoordinatorProtocol {
    func didEndCard()
}

class CardCoordinator: ChildCoordinator {
    var parentCoordinator: ParentCoordinator?
    var rootController: UINavigationController!
    
    init (parent: ParentCoordinator) {
        parentCoordinator = parent
    }
    
    func start() {
        let cardVC = CardVC()
        cardVC.coordinator = self
        rootController = UINavigationController(rootViewController: cardVC)
        parentCoordinator?.rootController.present(rootController, animated: true)
    }
    
    
    deinit {
        print("deinit CardCoordinator")
    }
    
    
}

extension CardCoordinator: CardCoordinatorProtocol {
    func didEndCard() {
        parentCoordinator?.childDidFinish(self)
        rootController = nil
    }
}
