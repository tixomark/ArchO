//
//  AuthVC.swift
//  ArchO
//
//  Created by Tixon Markin on 17.07.2023.
//

import Foundation
import UIKit

protocol SignInVCInput: AnyObject {
    func updateAccordingToLoginValidation(result isValid: Bool)
    func updateAccordingToPasswordValidation(result isValid: Bool)
    func activateSignInButton()
    func deactivateSignInButton()
    func adjustUIWhileSignInIsInProcess()
    func endSignIn()
    func showLoginAlert(title: String, message: String)
}

class SignInVC: UIViewController {
    weak var coordinator: AuthCoordinatorProtocol!
    var interactor: SignInInteractorInput?
    
    var header: UILabel!
    var profileIcon: UIImageView!
    var loginTF, passwordTF: UITextField!
    var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .archoBackgroundColor
        view.layer.cornerRadius = 20
        
        setUpUI()
        setUpConstraints()
    }
    
    private func setUpUI() {
        header = UILabel()
        header.text = "Добро пожаловать в профиль ArchO"
        header.numberOfLines = 0
        
        profileIcon = UIImageView()
        profileIcon.image = UIImage(named: IN.profileImage.rawValue)
        profileIcon.contentMode = .scaleAspectFit
        profileIcon.clipsToBounds = true
        
        loginTF = UITextField()
        loginTF.placeholder = "Номер телефона/E-mail"
        loginTF.layer.cornerRadius = 5
        loginTF.layer.borderWidth = 1
        loginTF.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        loginTF.clipsToBounds = true
        loginTF.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)
        
        passwordTF = UITextField()
        passwordTF.placeholder = "Пароль"
        passwordTF.layer.cornerRadius = 5
        passwordTF.layer.borderWidth = 1
        passwordTF.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        passwordTF.clipsToBounds = true
        passwordTF.addTarget(self, action: #selector(editingChangedIn(_:)), for: .editingChanged)
        
        signInButton = UIButton()
        signInButton.setTitle("Войти", for: .normal)
        signInButton.backgroundColor = .archoSecondaryColor
        signInButton.layer.cornerRadius = 24
        signInButton.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        deactivateSignInButton()
        
        view.addSubviews(header, profileIcon, loginTF, passwordTF, signInButton)
    }
    
    private func setUpConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileIcon.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            profileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileIcon.heightAnchor.constraint(equalToConstant: 56),
            profileIcon.widthAnchor.constraint(equalTo: profileIcon.heightAnchor),
            loginTF.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 24),
            loginTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginTF.heightAnchor.constraint(equalToConstant: 48),
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 16),
            passwordTF.leadingAnchor.constraint(equalTo: loginTF.leadingAnchor),
            passwordTF.trailingAnchor.constraint(equalTo: loginTF.trailingAnchor),
            passwordTF.heightAnchor.constraint(equalTo: loginTF.heightAnchor),
            signInButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 16),
            signInButton.widthAnchor.constraint(equalToConstant: 160),
            signInButton.heightAnchor.constraint(equalToConstant: 48),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
         ])
    }
    
    @objc func editingChangedIn(_ sender: UITextField) {
        guard let text = sender.text else { return }
        switch sender {
        case loginTF:
            interactor?.loginDidChange(text)
        case passwordTF:
            interactor?.passwordDidChange(text)
        default:
            print("SignInVC error in 'editingChangedIn'")
        }
    }
    
    @objc func didTapSignInButton(_ sender: UIButton) {
        interactor?.trySignInUsing(login: loginTF.text ?? "",
                                   password: passwordTF.text ?? "")
    }
    
    deinit {
        print("deinit SignInVC")
    }
}

extension SignInVC: SignInVCInput {

    func updateAccordingToLoginValidation(result isValid: Bool) {
        let newColor: UIColor = isValid ? .archoSecondaryColor : .archoRed
        loginTF.layer.borderColor = newColor.cgColor
    }
    
    func updateAccordingToPasswordValidation(result isValid: Bool) {
        let newColor: UIColor = isValid ? .archoSecondaryColor : .archoRed
        passwordTF.layer.borderColor = newColor.cgColor
    }
    
    func activateSignInButton() {
        signInButton.isEnabled = true
        signInButton.alpha = 1
    }
    
    func deactivateSignInButton() {
        signInButton.isEnabled = false
        signInButton.alpha = 0.7
    }
    
    func adjustUIWhileSignInIsInProcess() {
        deactivateSignInButton()
        loginTF.isEnabled = false
        passwordTF.isEnabled = false
    }
    
    func endSignIn() {
        coordinator.dismissModule()
    }
    
    func showLoginAlert(title: String, message: String) {
        activateSignInButton()
        loginTF.isEnabled = true
        passwordTF.isEnabled = true
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
