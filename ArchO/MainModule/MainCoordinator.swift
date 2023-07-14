//
//  MainCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func didTapMessagesButton()
    func didTapAddCardButton()
    func didTapSettingsButton()
    func didTapProfileButton()
}

class MainCoordinator: ParentCoordinator {
    var rootController: UINavigationController!
    var childCoordinators: [ChildCoordinator]?
    
    init() {
        rootController = UINavigationController()
    }
    
    func start() {
        let mainVC = MainVC()
        mainVC.coordinator = self
        rootController.viewControllers = [mainVC]
    }
    
    func childDidFinish(_ child: ChildCoordinator) {
        guard childCoordinators != nil else { return }
        for (index, coordinator) in childCoordinators!.enumerated() {
            if coordinator === child {
                childCoordinators?.remove(at: index)
                break
            }
        }
    }
    
    deinit {
        print("deinit MainCoordinator")
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func didTapMessagesButton() {
        let messagesCoordinator = MessagesCoordinator(parent: self)
        childCoordinators?.append(messagesCoordinator)
        messagesCoordinator.start()
    }
    
    func didTapAddCardButton() {
        let cardCoordinator = CardCoordinator(parent: self)
        childCoordinators?.append(cardCoordinator)
        cardCoordinator.start()
    }
    
    func didTapSettingsButton() {
        let settingsCoordinator = SettingsCoordinator(parent: self)
        childCoordinators?.append(settingsCoordinator)
        settingsCoordinator.start()
    }
    
    func didTapProfileButton() {
        let profileCoordinator = ProfileCoordinator(parent: self)
        childCoordinators?.append(profileCoordinator)
        profileCoordinator.start()
    }
    
    
}
