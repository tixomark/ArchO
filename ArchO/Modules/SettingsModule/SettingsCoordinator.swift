//
//  SettingsCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol SettingsCoordinatorProtocol: AnyObject {
    func didEndSettings()
}

class SettingsCoordinator: ChildCoordinator {
    var rootController: UINavigationController!
    var parentCoordinator: ParentCoordinator
    
    init (parent: ParentCoordinator) {
        parentCoordinator = parent
    }
    
    func start() {
        let settingsVC = SettingsVC()
        settingsVC.coordinator = self
        rootController = UINavigationController(rootViewController: settingsVC)
        parentCoordinator.rootController.present(rootController, animated: true)
    }
    
    deinit {
        print("deinit SettingsCoordinator")
    }
}

extension SettingsCoordinator: SettingsCoordinatorProtocol {
    func didEndSettings() {
        parentCoordinator.childDidFinish(self)
        rootController.viewControllers = []
    }
}
