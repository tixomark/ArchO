//
//  UserInfoInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 30.08.2023.
//

import Foundation

protocol UserInfoInteractorInput {
    func requestUserInfoData()
    func getUserInfoFieldData(_ fieldType: UserInfoCellContentType) -> DBUserContactField?
    func editingChanged(toText text: String, inCellOfType type: UserInfoCellContentType)
    func indicatorSwitched(toValue value: Bool, inCellOfType type: UserInfoCellContentType)
    func didTapDoneButton()
}

extension UserInfoInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.auth, .userManager]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        authService = (services[.auth] as! FBAuthProtocol)
        userManager = (services[.userManager] as! DBUserContactDataManagerProtocol)
    }
}

class UserInfoInteractor {
    var presenter: UserInfoPresenterInput!
    var authService: FBAuthProtocol!
    var userManager: DBUserContactDataManagerProtocol!
    var userContactData: DBUserContactData!
    var modifiedUserContactData: DBUserContactData!
    
    deinit {
        print("deinit UserInfoIntrector")
    }
}

extension UserInfoInteractor: UserInfoInteractorInput {
    func requestUserInfoData() {
        guard let uid = authService.curentUserID else { return }
        userManager.getContactData(forUser: uid) { [weak self] data in
            self?.userContactData = data
            self?.presenter.makeViewRequestForTableViewUpdates()
            self?.modifiedUserContactData = data
        }
    }
    
    func getUserInfoFieldData(_ fieldType: UserInfoCellContentType) -> DBUserContactField? {
        var someValue: DBUserContactField?
        guard userContactData != nil else { return someValue }
        switch fieldType {
        case .name:
            someValue = userContactData.name
        case .lastName:
            someValue = userContactData.lastName
        case .phoneNumber:
            someValue = userContactData.phoneNumber
        case .email:
            someValue = userContactData.email
        case .country:
            someValue = userContactData.country
        case .city:
            someValue = userContactData.city
        }
        return someValue
    }
    
    func editingChanged(toText text: String, inCellOfType type: UserInfoCellContentType) {
        switch type {
        case .name:
            modifiedUserContactData.name?.value = text
        case .lastName:
            modifiedUserContactData.lastName?.value = text
        case .phoneNumber:
            modifiedUserContactData.phoneNumber?.value = text
        case .email:
            modifiedUserContactData.email?.value = text
        case .country:
            modifiedUserContactData.country?.value = text
        case .city:
            modifiedUserContactData.city?.value = text
        }
    }
    
    func indicatorSwitched(toValue value: Bool, inCellOfType type: UserInfoCellContentType) {
        switch type {
        case .name:
            modifiedUserContactData.name?.isSelected = value
        case .lastName:
            modifiedUserContactData.lastName?.isSelected = value
        case .phoneNumber:
            modifiedUserContactData.phoneNumber?.isSelected = value
        case .email:
            modifiedUserContactData.email?.isSelected = value
        case .country:
            modifiedUserContactData.country?.isSelected = value
        case .city:
            modifiedUserContactData.city?.isSelected = value
        }
    }
    
    func didTapDoneButton() {
        if userContactData != modifiedUserContactData {
            guard let uid = authService.curentUserID else { return }
            userManager.updateContactData(modifiedUserContactData, forUser: uid)
        }
        presenter.endUserInfo()
    }
}
