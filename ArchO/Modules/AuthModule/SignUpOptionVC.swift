//
//  SignUpOptionVC.swift
//  ArchO
//
//  Created by Tixon Markin on 10.08.2023.
//

import Foundation
import UIKit

class SignUpOptionVC: UIViewController {
    
    weak var coordinator: AuthCoordinatorSignUpProtocol!
    
    var createAccountLabel: UILabel!
    var mainImageView: UIImageView!
    var emailSignUpButton, phoneSignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .archoBackgroundColor
        setUpUI()
        setUpConstraints()
    }
    
    deinit {
        print("deinit SignUpOptionVC")
    }
    
    private func setUpUI() {
        createAccountLabel = UILabel()
        createAccountLabel.text = "Создайте аккаунт"
        
        mainImageView = UIImageView()
        mainImageView.image = UIImage(named: IN.profileIcon.rawValue)
        mainImageView.contentMode = .scaleAspectFit
        
        phoneSignUpButton = UIButton()
        phoneSignUpButton.setTitle("Продолжить по номеру телефона", for: .normal)
        phoneSignUpButton.backgroundColor = .archoSecondaryColor
        phoneSignUpButton.layer.cornerRadius = 24
        phoneSignUpButton.addTarget(self, action: #selector(didTapContinueButton(_:)), for: .touchUpInside)
        
        emailSignUpButton = UIButton()
        emailSignUpButton.setTitle("Продолжить c Email", for: .normal)
        emailSignUpButton.backgroundColor = .archoSecondaryColor
        emailSignUpButton.layer.cornerRadius = 24
        emailSignUpButton.addTarget(self, action: #selector(didTapContinueButton(_:)), for: .touchUpInside)
        
        view.addSubviews(createAccountLabel, mainImageView, phoneSignUpButton, emailSignUpButton)
        
    }
    
    private func setUpConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            createAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainImageView.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 131),
            mainImageView.heightAnchor.constraint(equalToConstant: 128),
            mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneSignUpButton.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 169),
            phoneSignUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            phoneSignUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneSignUpButton.heightAnchor.constraint(equalToConstant: 48),
            emailSignUpButton.topAnchor.constraint(equalTo: phoneSignUpButton.bottomAnchor, constant: 24),
            emailSignUpButton.leadingAnchor.constraint(equalTo: phoneSignUpButton.leadingAnchor),
            emailSignUpButton.trailingAnchor.constraint(equalTo: phoneSignUpButton.trailingAnchor),
            emailSignUpButton.heightAnchor.constraint(equalTo: phoneSignUpButton.heightAnchor),
            emailSignUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -106)
        ])
    }
    
    
    @objc func didTapContinueButton(_ sender: UIButton) {
        switch sender {
        case phoneSignUpButton:
            print("user selected phoneAuth method")
        case emailSignUpButton:
            coordinator.goToEmailSignUpScreen()
        default:
            print("User did tap undefined button")
        }
    }
    
}
