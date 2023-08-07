//
//  AuthOptionVC.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation
import UIKit

class AuthOptionVC: UIViewController {
    weak var coordinator: AuthCoordinatorProtocol!
    
    var header: UILabel!
    var profileIcon: UIImageView!
    var signInButton, signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .archoBackgroundColor
        view.layer.cornerRadius = 20
        setUpUI()
        setUpConstraints()
        
    }

    deinit {
        print("deinit AuthOptionVC")
    }
    
    private func setUpUI() {
        header = UILabel()
        header.text = "Добро пожаловать в профиль ArchO"
        header.numberOfLines = 0
        
        profileIcon = UIImageView()
        profileIcon.image = UIImage(named: IN.profileImage.rawValue)
        profileIcon.contentMode = .scaleAspectFit
        profileIcon.clipsToBounds = true
        
        signInButton = UIButton()
        signInButton.setTitle("Вход", for: .normal)
        signInButton.backgroundColor = .archoSecondaryColor
        signInButton.layer.cornerRadius = 24
        signInButton.addTarget(self,
                               action: #selector(didTapSignInOption),
                               for: .touchUpInside)
        
        signUpButton = UIButton()
        signUpButton.setTitle("Регистрация", for: .normal)
        signUpButton.backgroundColor = .archoSecondaryColor
        signUpButton.layer.cornerRadius = 24
        signUpButton.addTarget(self,
                               action: #selector(didTapSignUpOption),
                               for: .touchUpInside)
        
        view.addSubviews(header, profileIcon, signInButton, signUpButton)
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
            signInButton.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 16),
            signInButton.widthAnchor.constraint(equalToConstant: 160),
            signInButton.heightAnchor.constraint(equalToConstant: 48),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.topAnchor.constraint(equalTo: signInButton.topAnchor),
            signUpButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor),
            signUpButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
         ])
    }
    
    @objc func didTapSignInOption() {
        coordinator.goToSignInScreen()
    }
    
    @objc func didTapSignUpOption() {
        coordinator.goToSignUpScreen()
    }
}

