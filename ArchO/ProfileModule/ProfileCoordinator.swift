//
//  ProfileCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol ProfileCoordinatorProtocol {
    func didEndProfile()
}

class ProfileCoordinator: ChildCoordinator {
    var parentCoordinator: ParentCoordinator?
    var rootController: UINavigationController!
    
    init (parent: ParentCoordinator) {
        parentCoordinator = parent
    }
    
    func start() {
        let profileVC = ProfileVC()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        profileVC.coordinator = self
        profileVC.interactor = interactor
        interactor.presenter = presenter
        presenter.view = profileVC
        rootController = UINavigationController(rootViewController: profileVC)
        parentCoordinator?.rootController.present(rootController, animated: true)
    }
    
    deinit {
        print("deinit ProfileCoordinator")
    }
    
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func didEndProfile() {
        parentCoordinator?.childDidFinish(self)
        rootController = nil
    }
}
