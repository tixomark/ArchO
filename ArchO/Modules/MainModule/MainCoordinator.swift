//
//  MainCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func showMessagesScreen()
    func showCardScreen()
    func showSettingsScreen()
    func showProfileScreen()
    func showAuthScreen()
}

class MainCoordinator: ParentCoordinator, ServiceDistributor {
    var rootController: UINavigationController!
    var childCoordinators: [ChildCoordinator]
    var serviceInjector: ServiceInjector?
    
    init() {
        rootController = UINavigationController()
        childCoordinators = []
    }
    
    func start() {
        let mainVC = MainVC()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        mainVC.interactor = interactor
        interactor.presenter = presenter
        presenter.view = mainVC
        mainVC.coordinator = self
        serviceInjector?.injectServices(forObject: interactor)
        rootController?.viewControllers = [mainVC]
    }
    
    func childDidFinish(_ child: ChildCoordinator) {
        guard !childCoordinators.isEmpty else { return }
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    deinit {
        print("deinit MainCoordinator")
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func showMessagesScreen() {
        let messagesCoordinator = MessagesCoordinator(parent: self)
        childCoordinators.append(messagesCoordinator)
        messagesCoordinator.start()
    }
    
    func showCardScreen() {
        let cardCoordinator = CardCoordinator(parent: self)
        childCoordinators.append(cardCoordinator)
        cardCoordinator.start()
    }
    
    func showSettingsScreen() {
        let settingsCoordinator = SettingsCoordinator(parent: self)
        childCoordinators.append(settingsCoordinator)
        settingsCoordinator.start()
    }
    
    
    
    func showProfileScreen() {
        let profileCoordinator = ProfileCoordinator(parent: self)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
    
    func showAuthScreen() {
        let authCoordinator = AuthCoordinator(parent: self)
        childCoordinators.append(authCoordinator)
        authCoordinator.start()
    }
    
}
