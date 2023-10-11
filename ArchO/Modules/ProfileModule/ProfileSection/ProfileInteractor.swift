//
//  ProfileInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfileInteractorInput {
    func requestUserSignOut()
    func didTapEdit()
}

extension ProfileInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.auth, .userManager]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        authService = (services[.auth] as! FBAuthProtocol)
        userManager = (services[.userManager] as! DBUserManagerProtocol)
    }
}

class ProfileInteractor {
    var presenter: ProfilePresenterInput!
    var authService: FBAuthProtocol!
    var userManager: DBUserManagerProtocol!
    
    deinit {
        print("deinit ProfileIntrector")
    }
}

extension ProfileInteractor: ProfileInteractorInput {
    func requestUserSignOut() {
        if authService.signOut() {
            presenter.signOutSucceed()
        } else {
            presenter.signOutFailed()
        }
    }
    
    func didTapEdit() {
        
//        guard let uid = authService.curentUserID else { return }
//        userManager.updateUserContactData(userId: uid, data: .init(name: "frigerator 300000eeee"))
    }
}

