//
//  ProfilePresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfilePresenterProtocol {
    var view: ProfileVCProtocol? {get set}
}

class ProfilePresenter {
    var view: ProfileVCProtocol?
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
}
