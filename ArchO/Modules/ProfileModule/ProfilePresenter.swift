//
//  ProfilePresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileVCInputProtocol? {get set}
}


class ProfilePresenter {
    var view: ProfileVCInputProtocol?
    
}

protocol ProfilePresenterInputProtocol {
    func fetchedDataToPresenter()
}

extension ProfilePresenter: ProfilePresenterInputProtocol {
    func fetchedDataToPresenter() {
        view?.setUserData()
    }
}
