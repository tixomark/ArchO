//
//  SignInInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 22.07.2023.
//

import Foundation

protocol SignInInteractorInput {
    func loginDidChange(_ text: String)
    func passwordDidChange(_ text: String)
    func trySignInUsing(login: String, password: String)
}

extension SignInInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.auth]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        authService = (services[.auth] as! FBAuthProtocol)
    }
}

class SignInInteractor {
    var presenter: SignInPresenterInput?
    var authService: FBAuthProtocol!
    let evaluator: Evaluator
    
    init() {
        evaluator = Evaluator()
    }
    
    deinit {
        print("deinit SignInInteractor")
    }
    
}

extension SignInInteractor: SignInInteractorInput {
    func loginDidChange(_ text: String) {
        let isLoginValid = evaluator.isValidEmail(text)
        presenter?.loginValidationResult(isLoginValid)
    }
    
    func passwordDidChange(_ text: String) {
        let isPasswordValid = evaluator.isValidPassword(text)
        presenter?.passwordValidationResult(isPasswordValid)
    }
    
    func trySignInUsing(login: String, password: String) {
        presenter?.adjustUIWhileSignInIsInProcess()
        authService.signInUsing(email: login, password: password) { error in
            guard error == nil else {
                self.presenter?.authAttemptDidResult(in: error!)
                return
            }
            self.presenter?.authAttemptSucceed()
        }
        
    }
}
