//
//  AuthCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation
import UIKit

protocol AuthCordinatorFinishProtocol: AnyObject {
    func didEndAuth()
}

protocol AuthCoordinatorProtocol: AnyObject {
    func goToSignInScreen()
    func goToSignUpScreen()
    func dismissModule()
    
}

class AuthCoordinator: ChildCoordinator, ServiceDistributor {
    var parentCoordinator: ParentCoordinator
    var rootController: UINavigationController!
    var serviceInjector: ServiceInjector?
    
    init(parent: ParentCoordinator) {
        rootController = AuthNC()
        parentCoordinator = parent
        if let parent = parent as? ServiceDistributor {
            serviceInjector = parent.serviceInjector
        }
    }
    
    func start() {
        (rootController as? AuthNC)?.coordinator = self
        let optionVC = AuthOptionVC()
        optionVC.coordinator = self
        rootController?.viewControllers = [optionVC]
        rootController?.modalPresentationStyle = .pageSheet
        parentCoordinator.rootController.present(rootController!, animated: true)
    }
    
    deinit {
        print("deinit AuthCoordinator")
    }
}

extension AuthCoordinator: AuthCordinatorFinishProtocol {
    func didEndAuth() {
        parentCoordinator.childDidFinish(self)
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func goToSignInScreen() {
        let signInVC = SignInVC()
        let interactor = SignInInteractor()
        let presenter = SignInPresenter()
        signInVC.coordinator = self
        signInVC.interactor = interactor
        interactor.presenter = presenter
        presenter.view = signInVC
        serviceInjector?.injectServices(forObject: interactor)
        rootController?.pushViewController(signInVC, animated: true)
    }
    
    func goToSignUpScreen() {
        
    }
    
    func dismissModule() {
        rootController.dismiss(animated: true)
        didEndAuth()
    }
    
}
