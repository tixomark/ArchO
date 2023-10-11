//
//  ProfileNC.swift
//  ArchO
//
//  Created by Tixon Markin on 18.08.2023.
//

import Foundation
import UIKit

class ProfileNC: UINavigationController {
    weak var coordinator: ProfileCoordinatorFinishProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 20
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.dismissModule()
    }

    deinit {
        print("deinit ProfileNC")
    }
}
