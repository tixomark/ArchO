//
//  SignUpPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 10.08.2023.
//

import Foundation

protocol SignUpPresenterInput {
    func emailValidation(result isValid: Bool)
    func passwordValidation(result isValid: Bool, password: String)
    func passwordConf(newValue password: String)
}

class SignUpPresenter {
    weak var view: SignUpVCInput?
    
    private var isEmailValid: Bool?
    private var isPasswordValid: Bool?
    private var currentPassword: String = ""
    private var currentConfPassword: String = ""
    private var isPasswordConfValid: Bool {
        currentPassword == currentConfPassword
    }
    private var isAuthPossible: Bool {
        (isEmailValid ?? false) && (isPasswordValid ?? false) && isPasswordConfValid
    }
    
    deinit {
        print("deinit SignUpPresenter")
    }
    
    private func checkIfAuthPossible() {
        isAuthPossible ? view?.activateContinueButton() : view?.deactivateContinueButton()
    }
}

extension SignUpPresenter: SignUpPresenterInput {
    func emailValidation(result isValid: Bool) {
        guard isEmailValid != isValid else { return }
        isEmailValid = isValid
        switch isValid {
        case true:
            view?.updateUIToIndicateEmailIsGood()
        case false:
            view?.updateUIToIndicateEmailProblem()
        }
        checkIfAuthPossible()
    }
    
    func passwordValidation(result isValid: Bool, password: String) {
        currentPassword = password
        updatePasswordConfState()
        
        guard isPasswordValid != isValid else { return }
        isPasswordValid = isValid
        switch isValid {
        case true:
            view?.updateUIToIndicatePasswordIsGood()
            view?.activatePasswordConfTextField()
        case false:
            view?.updateUIToIndicatePasswordProblem()
            view?.deactivatePasswordConfTextField()
        }
        checkIfAuthPossible()
    }
    
    func passwordConf(newValue password: String) {
        currentConfPassword = password
        updatePasswordConfState()
        checkIfAuthPossible()
    }
    
    private func updatePasswordConfState() {
        switch isPasswordConfValid {
        case true:
            view?.updateUIToIndicatePasswordConfIsGood()
        case false:
            view?.updateUIToIndicatePasswordConfProblem()
        }
    }
    
    
}
