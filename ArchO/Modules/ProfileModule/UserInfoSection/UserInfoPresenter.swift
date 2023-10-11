//
//  UserInfoPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 30.08.2023.
//

import Foundation

protocol UserInfoPresenterInput {
    func makeViewRequestForTableViewUpdates()
    func endUserInfo()
}


class UserInfoPresenter {
    weak var view: UserInfoVCInput?
    
    
    deinit {
        print("deinit UserInfoPresenter")
    }
}

extension UserInfoPresenter: UserInfoPresenterInput {
    func makeViewRequestForTableViewUpdates() {
        view?.reloadTableView()
    }
    
    func endUserInfo() {
        view?.endUserInfo()
    }
    
}
