//
//  AuthNC.swift
//  ArchO
//
//  Created by Tixon Markin on 07.08.2023.
//

import UIKit

class AuthNC: UINavigationController {
    weak var coordinator: AuthCordinatorFinishProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.cornerRadius = 20
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.dismissModule()
    }

}
