//
//  MainVC.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol MainVCInput {
    func goToProfileSection()
    func goToAuthSection()
}

class MainVC: UIViewController {
    var coordinator: MainCoordinatorProtocol!
    var interactor: MainInteractorInput!
    var messagesButton, cardButton, settingsButton, profileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .gray
        
        setUpUI()
        setUpConstraints()
        
    }
    
    private func setUpUI() {
        messagesButton = UIButton()
        view.addSubview(messagesButton)
        messagesButton.backgroundColor = .blue
        messagesButton.addTarget(self, action: #selector(didTapOnMessagesButton(_:)), for: .touchUpInside)
        
        cardButton = UIButton()
        view.addSubview(cardButton)
        cardButton.backgroundColor = .red
        cardButton.addTarget(self, action: #selector(didTapOnCardButton(_:)), for: .touchUpInside)
        
        settingsButton = UIButton()
        view.addSubview(settingsButton)
        settingsButton.backgroundColor = .green
        settingsButton.addTarget(self, action: #selector(didTapOnSettingsButton(_:)), for: .touchUpInside)
        
        profileButton = UIButton()
        view.addSubview(profileButton)
        profileButton.backgroundColor = .yellow
        profileButton.addTarget(self, action: #selector(didTapOnProfileButton(_:)), for: .touchUpInside)
        
    }
    
    private func setUpConstraints() {
        messagesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messagesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            messagesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            messagesButton.heightAnchor.constraint(equalToConstant: 70),
            messagesButton.widthAnchor.constraint(equalTo: messagesButton.heightAnchor)])
        
        cardButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            cardButton.heightAnchor.constraint(equalToConstant: 100),
            cardButton.widthAnchor.constraint(equalTo: cardButton.heightAnchor)])
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            settingsButton.heightAnchor.constraint(equalToConstant: 70),
            settingsButton.widthAnchor.constraint(equalTo: settingsButton.heightAnchor)])
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            profileButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            profileButton.heightAnchor.constraint(equalToConstant: 50),
            profileButton.widthAnchor.constraint(equalTo: profileButton.heightAnchor)])
    }
    
    @objc func didTapOnMessagesButton(_ sender: UIButton) {
        coordinator.showMessagesScreen()
    }
    @objc func didTapOnCardButton(_ sender: UIButton) {
        coordinator.showCardScreen()
    }
    @objc func didTapOnSettingsButton(_ sender: UIButton) {
        coordinator.showSettingsScreen()
    }
    @objc func didTapOnProfileButton(_ sender: UIButton) {
        interactor.didTapUserIcon()
    }
}

extension MainVC: MainVCInput {
    func goToProfileSection() {
        coordinator.showProfileScreen()
    }
    
    func goToAuthSection() {
        coordinator.showAuthScreen()
    }
    
    
}
