//
//  ProfileVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import UIKit

protocol ProfileVCInput: AnyObject {
    func endProfile()
}


class ProfileVC: UIViewController {
    weak var coordinator: ProfileCoordinatorProtocol!
    var interactor: ProfileInteractorInput!
    
    var userImage: UIImageView!
    var tableHeaderLabel: UILabel!
    var editButton, signOutButton: UIButton!
    var cardTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .archoBackgroundColor
        setUpUI()
        setUpConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        print("deinit ProfileVC")
    }
    
    private func setUpUI() {
        userImage = UIImageView()
        userImage.image = UIImage(named: IN.profileIcon.rawValue)
        userImage.contentMode = .scaleAspectFit
        userImage.clipsToBounds = true
        
        editButton = UIButton()
        editButton.setTitle("Править", for: .normal)
        editButton.setTitleColor(.black, for: .normal)
        editButton.layer.cornerRadius = 18
        editButton.layer.borderWidth = 1
        editButton.addTarget(self, action: #selector(didTapEditButton(_:)), for: .touchUpInside)
        
        signOutButton = UIButton()
        signOutButton.setTitle("Выйти", for: .normal)
        signOutButton.setTitleColor(.black, for: .normal)
        signOutButton.layer.cornerRadius = 18
        signOutButton.layer.borderWidth = 1
        signOutButton.addTarget(self, action: #selector(didTapSignOutButton(_:)), for: .touchUpInside)
        
        tableHeaderLabel = UILabel()
        tableHeaderLabel.text = "Карты пользователя"
        tableHeaderLabel.frame.size.height = 20
        
        cardTable = UITableView()
        cardTable.delegate = self
        cardTable.dataSource = self
        cardTable.separatorStyle = .none
        
        view.addSubviews(userImage, editButton, signOutButton, tableHeaderLabel, cardTable)
        
        
    }
    
    private func setUpConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userImage.heightAnchor.constraint(equalToConstant: 72),
            userImage.widthAnchor.constraint(equalTo: userImage.heightAnchor),
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            editButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 36),
            editButton.heightAnchor.constraint(equalToConstant: 36),
            signOutButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 16),
            signOutButton.centerXAnchor.constraint(equalTo: editButton.centerXAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 36),
            tableHeaderLabel.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 16),
            tableHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardTable.topAnchor.constraint(equalTo: tableHeaderLabel.bottomAnchor, constant: 5),
            cardTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cardTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func didTapEditButton(_ sender: UIButton) {
        coordinator.showUserInfoSection()
    }
    
    @objc func didTapSignOutButton(_ sender: UIButton) {
        interactor.requestUserSignOut()
    }
}

extension ProfileVC: ProfileVCInput {
    func endProfile() {
        coordinator.dismissModule()
    }
}

extension ProfileVC: UITableViewDelegate {
    
}

extension ProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardCell()
        return cell
    }
    
    
}
