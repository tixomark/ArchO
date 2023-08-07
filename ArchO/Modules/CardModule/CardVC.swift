//
//  CardVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import UIKit

protocol CardVCProtocol {
    var coordinator: CardCoordinatorProtocol? {get set}
}

class CardVC: UIViewController {
    var coordinator: CardCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        coordinator?.didEndCard()
    }
    

    deinit {
        print("deinit CardVC")
    }

}

extension CardVC: CardVCProtocol {
    
}
