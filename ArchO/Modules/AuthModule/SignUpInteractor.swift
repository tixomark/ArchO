//
//  SignUpInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 10.08.2023.
//

import Foundation

protocol SignUpInteractorInput {
    func emailDidChange(_ text: String)
    func passwordDidChange(_ text: String)
    func passwordConfDidChange(_ text: String)
    func trySignUpUsing(email: String, password: String)
}

extension SignUpInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.auth, .userManager]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        authService = (services[.auth] as! FBAuthProtocol)
        userManager = (services[.userManager] as! DBUserManagerProtocol)
    }
}

class SignUpInteractor {
    var presenter: SignUpPresenterInput?
    var authService: FBAuthProtocol!
    var userManager: DBUserManagerProtocol!
    let evaluator: Evaluator
    
    init() {
        evaluator = Evaluator()
    }
    
    deinit {
        print("denint SignUpInteractor")
    }
}

extension SignUpInteractor: SignUpInteractorInput {
    func emailDidChange(_ text: String) {
        let isEmailValid = evaluator.isValidEmail(text)
        presenter?.emailValidation(result: isEmailValid)
    }
    
    func passwordDidChange(_ text: String) {
        let isPasswordValid = evaluator.isValidPassword(text)
        presenter?.passwordValidation(result: isPasswordValid, password: text)
    }
    
    func passwordConfDidChange(_ text: String) {
        presenter?.passwordConf(newValue: text)
    }
    
    func trySignUpUsing(email: String, password: String) {
        presenter?.adjustUIWhileSignUpIsInProcess()
        authService.signUpUsing(email: email, password: password) { result in
            switch result {
            case .success(let createdUser):
                self.userManager.setData(forUser: DBUser(FBUser: createdUser))
//                createNewUser(newUser: DBUser(FBUser: createdUser))
                self.presenter?.authAttemptSucceed()
            case .failure(let error):
                self.presenter?.authAttemptDidResult(in: error)
            }
        }
    }
    
}
