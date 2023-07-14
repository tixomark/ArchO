//
//  ProfileInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation

protocol ProfileInteractorProtocol {
    var presenter: ProfilePresenterProtocol? {get set}
}

class ProfileInteractor {
    var presenter: ProfilePresenterProtocol?
}

extension ProfileInteractor: ProfileInteractorProtocol {
    
}

