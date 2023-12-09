//
//  MainPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 26.07.2023.
//

import Foundation

protocol MainPresenterInput {
    func didRecieveTapOnUserIcon(_ isAuthed: Bool)
    func didRecieveTapOnCardIcon(authState isAuthed: Bool)
    
}

class MainPresenter {
    var view: MainVCInput!
}

extension MainPresenter: MainPresenterInput {
    func didRecieveTapOnUserIcon(_ isAuthed: Bool) {
        isAuthed ? view.goToProfileSection() : view.goToAuthSection()
    }
    
    func didRecieveTapOnCardIcon(authState isAuthed: Bool) {
        isAuthed ? view.goToCardSection() : view.showAuthAlert()
    }
    
    
    
}
