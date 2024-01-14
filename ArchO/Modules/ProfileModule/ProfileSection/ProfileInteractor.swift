//
//  ProfileInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfileInteractorInput {
    func didTapSignOutButton()
    func didTapEditButton()
}

extension ProfileInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.auth, .userManager, .cardManager]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        authService = (services[.auth] as! FBAuthProtocol)
        userManager = (services[.userManager] as! DBUserManagerProtocol)
        cardManager = (services[.cardManager] as! DBCardManagerProtocol)
    }
}

class ProfileInteractor {
    var presenter: ProfilePresenterInput!
    var authService: FBAuthProtocol!
    var userManager: DBUserManagerProtocol!
    var cardManager: DBCardManagerProtocol!
    
    deinit {
        print("deinit ProfileIntrector")
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func didTapSignOutButton() {
        if authService.signOut() {
            presenter.signOutSucceed()
        } else {
            presenter.signOutFailed()
        }
    }
    
    func didTapEditButton() {
        
//        guard let uid = authService.curentUserID else { return }
//        userManager.updateUserContactData(userId: uid, data: .init(name: "frigerator 300000eeee"))
    }
}

