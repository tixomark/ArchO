//
//  ProfileVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import UIKit

protocol ProfileVCProtocol {
    var coordinator: ProfileCoordinatorProtocol? {get set}
    var interactor: ProfileInteractorProtocol? {get set}
}

class ProfileVC: UIViewController {
    var coordinator: ProfileCoordinatorProtocol?
    var interactor: ProfileInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
    }
    
    deinit {
        print("deinit ProfileVC")
    }

}

extension ProfileVC: ProfileVCProtocol {
    
}
