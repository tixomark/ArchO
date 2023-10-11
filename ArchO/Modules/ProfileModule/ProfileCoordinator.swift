//
//  ProfileCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit


protocol ProfileCoordinatorFinishProtocol: AnyObject {
    func dismissModule()
}

protocol ProfileCoordinatorProtocol: ProfileCoordinatorFinishProtocol, AnyObject {
    func showUserInfoSection()
}

class ProfileCoordinator: ChildCoordinator, ServiceDistributor {
    var parentCoordinator: ParentCoordinator
    var rootController: UINavigationController!
    var serviceInjector: ServiceInjector?
    
    init (parent: ParentCoordinator) {
        rootController = ProfileNC()
        parentCoordinator = parent
        if let parent = parent as? ServiceDistributor {
            serviceInjector = parent.serviceInjector
        }
    }
    
    func start() {
        (rootController as! ProfileNC).coordinator = self
        let profileVC = ProfileVC()
        let interactor = ProfileInteractor()
        let presenter = ProfilePresenter()
        profileVC.coordinator = self
        profileVC.interactor = interactor
        interactor.presenter = presenter
        presenter.view = profileVC
        serviceInjector?.injectServices(forObject: interactor)
        rootController.viewControllers = [profileVC]
        rootController?.modalPresentationStyle = .pageSheet
        parentCoordinator.rootController.present(rootController, animated: true)
    }
    
    deinit {
        print("deinit ProfileCoordinator")
    }
    
}

extension ProfileCoordinator: ProfileCoordinatorFinishProtocol {
    func dismissModule() {
        parentCoordinator.childDidFinish(self)
        rootController.dismiss(animated: true)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func showUserInfoSection() {
        let userInfoVC = UserInfoVC()
        let interactor = UserInfoInteractor()
        let presenter = UserInfoPresenter()
        userInfoVC.coordinator = self
        userInfoVC.interactor = interactor
        interactor.presenter = presenter
        presenter.view = userInfoVC
        serviceInjector?.injectServices(forObject: interactor)
        rootController.pushViewController(userInfoVC, animated: true)
    }
}
