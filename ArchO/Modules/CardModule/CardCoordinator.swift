//
//  CardsCoordinator.swift
//  ArchO
//
//  Created by Tixon Markin on 07.07.2023.
//

import Foundation
import UIKit

protocol CardCoordinatorFinishProtocol: AnyObject {
    func dismissModule()
}

protocol CardCoordinatorProtocol: CardCoordinatorFinishProtocol, AnyObject {
    
}

class CardCoordinator: ChildCoordinator, ServiceDistributor {
    var parentCoordinator: ParentCoordinator
    var rootController: UINavigationController!
    var serviceInjector: ServiceInjector?
    
    init (parent: ParentCoordinator) {
        rootController = CardNC()
        parentCoordinator = parent
        if let parent = parent as? ServiceDistributor {
            serviceInjector = parent.serviceInjector
        }
        
    }
    
    func start() {
        let firstVC = FirstVC()
        let mainInfoVC = MainInfoVC()
        let listOfWorksVC = ListOfWorksVC()
        let historicalBackgroungVC = HistoricalBackgroundVC()
        let additionalInfoVC = AdditionalInfoVC()
        
        let cardVC = CardPVC(viewControllers: [firstVC, mainInfoVC, listOfWorksVC,
                                               historicalBackgroungVC, additionalInfoVC])
        let interactor = CardInteractor()
        let presenter = CardPresenter()
        cardVC.coordinator = self
        cardVC.interactor = interactor
        interactor.presenter = presenter
        presenter.cardPVC = cardVC
        
        firstVC.interactor = interactor
        mainInfoVC.interactor = interactor
        listOfWorksVC.interactor = interactor
        historicalBackgroungVC.interactor = interactor
        additionalInfoVC.interactor = interactor
        
        presenter.firstView = firstVC
        presenter.mainInfoView = mainInfoVC
        presenter.listOfWorksView = listOfWorksVC
        presenter.historicalBackgroundView = historicalBackgroungVC
        presenter.additionalInfoView = additionalInfoVC
        
        serviceInjector?.injectServices(forObject: interactor)
        rootController.viewControllers = [cardVC]
        rootController.modalPresentationStyle = .fullScreen
        parentCoordinator.rootController.present(rootController, animated: true)
    }
    
    
    deinit {
        print("deinit CardCoordinator")
    }
    
    
}

extension CardCoordinator: CardCoordinatorProtocol {
    func dismissModule() {
        parentCoordinator.childDidFinish(self)
        rootController.dismiss(animated: true)
    }
}
