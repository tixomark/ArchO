//
//  SignUpVC.swift
//  ArchO
//
//  Created by Tixon Markin on 10.08.2023.
//

import Foundation
import UIKit

protocol SignUpVCInput: AnyObject {
    func activateContinueButton()
    func deactivateContinueButton()
    
    func activatePasswordConfTextField()
    func deactivatePasswordConfTextField()
    
    func updateUIToIndicateEmailIsGood()
    func updateUIToIndicateEmailProblem()
    
    func updateUIToIndicatePasswordIsGood()
    func updateUIToIndicatePasswordProblem()
    
    func updateUIToIndicatePasswordConfIsGood()
    func updateUIToIndicatePasswordConfProblem()
    
    func adjustUIWhileSignInIsInProcess()
    func endSignUp()
    func showLoginAlert(title: String, message: String)
}

class SignUpVC: UIViewController {
    weak var coordinator: AuthCoordinatorSignUpProtocol!
    var interactor: SignUpInteractorInput?
    
    var headerLabel: UILabel!
    var registrationIcon: UIImageView!
    var emailTextField, passwordTextField, passwordConfTextField: UITextField!
    var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .archoBackgroundColor
        setUpUI()
        setUpConstraints()
    }
    
    deinit {
        print("deinit SignUpVC")
    }
    
    private func setUpUI() {
        headerLabel = UILabel()
        headerLabel.text = "Регистрация"
        
        registrationIcon = UIImageView()
        registrationIcon.image = UIImage(.regIcon)
        registrationIcon.contentMode = .scaleAspectFit
        registrationIcon.clipsToBounds = true
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Адрес электронной почты"
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.cornerRadius = 5
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        emailTextField.clipsToBounds = true
        emailTextField.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Пароль"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        passwordTextField.clipsToBounds = true
        passwordTextField.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)
        
        passwordConfTextField = UITextField()
        passwordConfTextField.placeholder = "Подтвердите пароль"
        passwordConfTextField.autocapitalizationType = .none
        passwordConfTextField.layer.cornerRadius = 5
        passwordConfTextField.layer.borderWidth = 1
        passwordConfTextField.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        passwordConfTextField.clipsToBounds = true
        passwordConfTextField.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)
        deactivatePasswordConfTextField()
        
        continueButton = UIButton()
        continueButton.setTitle("Продолжить", for: .normal)
        continueButton.backgroundColor = .archoSecondaryColor
        continueButton.layer.cornerRadius = 24
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        deactivateContinueButton()
        
        view.addSubviews(headerLabel, registrationIcon, emailTextField, passwordTextField, passwordConfTextField, continueButton)
    }
    
    private func setUpConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationIcon.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            registrationIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationIcon.heightAnchor.constraint(equalToConstant: 96),
            registrationIcon.widthAnchor.constraint(equalToConstant: 80),
            emailTextField.topAnchor.constraint(equalTo: registrationIcon.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordConfTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordConfTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordConfTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            passwordConfTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            
            continueButton.topAnchor.constraint(equalTo: passwordConfTextField.bottomAnchor, constant: 16),
            continueButton.widthAnchor.constraint(equalToConstant: 196),
            continueButton.heightAnchor.constraint(equalToConstant: 48),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
        
    }
    
    @objc func didTapContinueButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        interactor?.trySignUpUsing(email: email, password: password)
    }
    
    @objc func editingChangedIn(_ sender: UITextField) {
        guard let text = sender.text else { return }
        switch sender {
        case emailTextField:
            interactor?.emailDidChange(text)
        case passwordTextField:
            interactor?.passwordDidChange(text)
        case passwordConfTextField:
            interactor?.passwordConfDidChange(text)
        default:
            print("SignUpVC error in 'editingChangedIn'")
        }
    }
    
}

extension SignUpVC: SignUpVCInput {
    func activateContinueButton() {
        continueButton.alpha = 1.0
        continueButton.isEnabled = true
    }
    
    func deactivateContinueButton() {
        continueButton.isEnabled = false
        continueButton.alpha = 0.7
    }
    
    func activatePasswordConfTextField() {
        passwordConfTextField.isEnabled = true
        passwordConfTextField.alpha = 1
    }
    
    func deactivatePasswordConfTextField() {
        passwordConfTextField.isEnabled = false
        passwordConfTextField.alpha = 0.7
    }
    
    func updateUIToIndicateEmailIsGood() {
        emailTextField.layer.borderColor = UIColor.archoSecondaryColor.cgColor
    }
    
    func updateUIToIndicateEmailProblem() {
        emailTextField.layer.borderColor = UIColor.archoRed.cgColor
    }
    
    func updateUIToIndicatePasswordIsGood() {
        passwordTextField.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        activatePasswordConfTextField()
    }
    
    func updateUIToIndicatePasswordProblem() {
        passwordTextField.layer.borderColor = UIColor.archoRed.cgColor
        deactivatePasswordConfTextField()
    }
    
    func updateUIToIndicatePasswordConfIsGood() {
        passwordConfTextField.layer.borderColor = UIColor.archoSecondaryColor.cgColor
    }
    
    func updateUIToIndicatePasswordConfProblem() {
        passwordConfTextField.layer.borderColor = UIColor.archoRed.cgColor
    }
    
    func adjustUIWhileSignInIsInProcess() {
        deactivateContinueButton()
        emailTextField.isEnabled = false
        passwordTextField.isEnabled = false
        passwordConfTextField.isEnabled = false
    }
    
    func endSignUp() {
        coordinator.showEmailVerificationScreen()
    }
    
    func showLoginAlert(title: String, message: String) {
        activateContinueButton()
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        passwordConfTextField.isEnabled = true

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

