//
//  AuthCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation
import UIKit

protocol AuthCordinatorFinishProtocol: AnyObject {
    func dismissModule()
}

protocol AuthCoordinatorProtocol: AuthCordinatorFinishProtocol, AnyObject {
    func goToSignInSection()
    func goToSignUpSection()
    
}

protocol AuthCoordinatorSignUpProtocol: AuthCordinatorFinishProtocol, AnyObject {
    func goToEmailSignUpScreen()
    func goToEmailVerificationScreen()
    
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
    func dismissModule() {
        parentCoordinator.childDidFinish(self)
        rootController.dismiss(animated: true)
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    func goToSignInSection() {
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
    
    func goToSignUpSection() {
        let signUpVC = SignUpOptionVC()
        signUpVC.coordinator = self
        rootController.pushViewController(signUpVC, animated: true)
    }

}

extension AuthCoordinator: AuthCoordinatorSignUpProtocol {
    func goToEmailSignUpScreen() {
        let signUpVC = SignUpVC()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        signUpVC.coordinator = self
        signUpVC.interactor = interactor
        interactor.presenter = presenter
        presenter.view = signUpVC
        serviceInjector?.injectServices(forObject: interactor)
        rootController.pushViewController(signUpVC, animated: true)
    }
    
    func goToEmailVerificationScreen() {
        
    }
}
