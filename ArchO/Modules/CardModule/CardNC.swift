//
//  CardNC.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

class CardNC: UINavigationController {
    weak var coordinator: CardCoordinatorFinishProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.backgroundColor = .archoBackgroundColor
        navigationBar.barTintColor = .archoBackgroundColor
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.dismissModule()
    }

    deinit {
        print("deinit CardNC")
    }

}
