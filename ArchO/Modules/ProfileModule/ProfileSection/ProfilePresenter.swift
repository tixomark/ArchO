//
//  ProfilePresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfilePresenterInput {
    func signOutSucceed()
    func signOutFailed()
}


class ProfilePresenter {
    weak var view: ProfileVCInput?
    
    
    deinit {
        print("deinit ProfilePresenter")
    }
}

extension ProfilePresenter: ProfilePresenterInput {
    func signOutSucceed() {
        view?.endProfile()
    }
    
    func signOutFailed() {
        
    }
}
