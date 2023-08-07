//
//  MainInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 26.07.2023.
//

import Foundation

protocol MainInteractorInput {
    func didTapUserIcon()
}

extension MainInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.auth]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        authService = (services[.auth] as! FBAuthProtocol)
    }
}

class MainInteractor {
    var presenter: MainPresenterInput!
    var authService: FBAuthProtocol!
}

extension MainInteractor: MainInteractorInput {
    func didTapUserIcon() {
        presenter.showModuleAccordingToUserAuthState(authService.isUserAuthed)
    }
}
