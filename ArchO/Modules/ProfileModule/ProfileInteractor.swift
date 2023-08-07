//
//  ProfileInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfileInteractorProtocol {
    var presenter: ProfilePresenterInputProtocol? {get set}
}


class ProfileInteractor {
    var presenter: ProfilePresenterInputProtocol?
    
    
}

protocol ProfileInteractorInputProtocol {
    func requestUserData()
}

extension ProfileInteractor: ProfileInteractorInputProtocol {
    func requestUserData() {
        presenter?.fetchedDataToPresenter()
    }
}

