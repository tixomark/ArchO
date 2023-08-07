//
//  SettingsNC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import Foundation
import UIKit

protocol SettingsVCProtocol {
    var coordinator: SettingsCoordinatorProtocol? {get set}
    
}

class SettingsVC: UIViewController, SettingsVCProtocol {
    var coordinator: SettingsCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didEndSettings()
    }
    
    deinit {
        print("deinit SettingsVC")
    }
}
