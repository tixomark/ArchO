//
//  MessagesVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.07.2023.
//

import UIKit

protocol MessagesVCProtocol {
    var coordinator: MessagesCoordinatorProtocol? {get set}
}

class MessagesVC: UIViewController {

    var coordinator: MessagesCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didEndMessages()
    }
    
    deinit {
        print("deinit MessagesVC")
    }

}

extension MessagesVC: MessagesVCProtocol {
    
}
