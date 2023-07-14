//
//  MessagesCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol MessagesCoordinatorProtocol {
    func didEndMessages()
}

class MessagesCoordinator: ChildCoordinator {
    var parentCoordinator: ParentCoordinator?
    var rootController: UINavigationController!
    
    init (parent: ParentCoordinator) {
        parentCoordinator = parent
    }
    
    func start() {
        let messagesVC = MessagesVC()
        messagesVC.coordinator = self
        rootController = UINavigationController(rootViewController: messagesVC)
        parentCoordinator?.rootController.present(rootController, animated: true)
    }
    
    deinit {
        print("deinit MessagesCoordinator")
    }
    
}

extension MessagesCoordinator: MessagesCoordinatorProtocol {
    func didEndMessages() {
        parentCoordinator?.childDidFinish(self)
        rootController = nil
    }
    
    
}
