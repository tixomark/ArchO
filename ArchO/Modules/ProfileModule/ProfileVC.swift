//
//  ProfileVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import UIKit

protocol ProfileVCProtocol {
    var coordinator: ProfileCoordinatorProtocol? {get set}
    var interactor: ProfileInteractorInputProtocol? {get set}
}


class ProfileVC: UIViewController {
    var coordinator: ProfileCoordinatorProtocol?
    var interactor: ProfileInteractorInputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        interactor?.requestUserData()
    }
    
    deinit {
        print("deinit ProfileVC")
    }

}

extension ProfileVC: ProfileVCProtocol {
    
}

protocol ProfileVCInputProtocol {
    func setUserData()
}

extension ProfileVC: ProfileVCInputProtocol {
    func setUserData() {
        view.backgroundColor = .archoRed
    }
}

