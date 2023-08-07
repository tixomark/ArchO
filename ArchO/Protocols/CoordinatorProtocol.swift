//
//  CoordinatorProtocol.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootController: UINavigationController! {get}
    func start()
}

protocol ParentCoordinator: Coordinator, AnyObject {
    var childCoordinators: [ChildCoordinator] {get set}
    func childDidFinish(_ child: ChildCoordinator)
}

protocol ChildCoordinator: Coordinator, AnyObject {
    var parentCoordinator: ParentCoordinator {get set}
}

