//
//  SignInPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 22.07.2023.
//

import Foundation

protocol SignInPresenterInput {
    func loginValidationResult(_ value: Bool)
    func passwordValidationResult(_ value: Bool)
    func adjustUIWhileSignInIsInProcess()
    func authAttemptSucceed()
    func authAttemptDidResult(in error: Error)
    
}

class SignInPresenter {
    weak var view: SignInVCInput?
    
    private var isLoginValid: Bool = false
    private var isPasswordValid: Bool = false
    
    private var isAuthPossible: Bool {
        isLoginValid && isPasswordValid
    }
    
    deinit {
        print("deinit SignInPresenter")
    }
}


extension SignInPresenter: SignInPresenterInput {
    
    func loginValidationResult(_ value: Bool) {
        isLoginValid = value
        view?.updateAccordingToLoginValidation(result: value)
        isAuthPossible ? view?.activateSignInButton() : view?.deactivateSignInButton()
    }
    
    func passwordValidationResult(_ value: Bool) {
        isPasswordValid = value
        view?.updateAccordingToPasswordValidation(result: value)
        if isAuthPossible {
            view?.activateSignInButton()
        } else {
            view?.deactivateSignInButton()
        }
    }
    
    func adjustUIWhileSignInIsInProcess() {
        view?.adjustUIWhileSignInIsInProcess()
    }
    
    func authAttemptSucceed() {
        view?.endSignIn()
    }
    
    func authAttemptDidResult(in error: Error) {
        let title = "Error"
        view?.showLoginAlert(title: title, message: error.localizedDescription)
    }
}

