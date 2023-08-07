//
//  MainPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 26.07.2023.
//

import Foundation

protocol MainPresenterInput {
    func showModuleAccordingToUserAuthState(_ isAuthed: Bool)
}

class MainPresenter {
    var view: MainVCInput!
}

extension MainPresenter: MainPresenterInput {
    func showModuleAccordingToUserAuthState(_ isAuthed: Bool) {
        switch isAuthed {
        case true:
            view.goToProfileSection()
        case false:
            view.goToAuthSection()
        }
    }
    
    
}
