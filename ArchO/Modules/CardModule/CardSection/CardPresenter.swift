//
//  CardPresenter.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import Foundation

protocol CardPresenterInput {
    var persistentData: PersistentData { get }
    func setDataFor(_ view: Views)
    func setDelegatesOfItems(inView view: Views, toObject object: AnyObject)
    
}

class CardPresenter {
    weak var cardPVC: CardPVCInput!
    weak var firstView: FirstVCInput!
    weak var mainInfoView: MainInfoVCInput!
    weak var listOfWorksView: ListOfWorksVCInput!
    weak var historicalBackgroundView: HistoricalBackgroundVCInput!
    weak var additionalInfoView: AdditionalInfoVCInput!
    
    var persistentData = PersistentData()
    
    deinit {
        print("deinit CardPresenter")
    }
}

extension CardPresenter: CardPresenterInput {
func setDataFor(_ view: Views) {
        let itemsData = persistentData.sectionData[view.rawValue]
        let headerData = persistentData.sectionHeaders[view.rawValue]
        switch view {
        case .firstView:
            firstView.populateItemswithData(itemsData, headersData: [])
        case .mainInfo:
            mainInfoView.populateItemswithData(itemsData, headersData: headerData)
        case .listOfWorks:
            listOfWorksView.populateItemswithData(itemsData, headersData: headerData)
        case .histBackground:
            historicalBackgroundView.populateItemswithData(itemsData, headersData: headerData)
        case .additionalInfo:
            additionalInfoView.populateItemswithData(itemsData, headersData: headerData)
        }
    }
    
    func setDelegatesOfItems(inView view: Views, toObject object: AnyObject) {
        switch view {
        case .firstView:
            firstView.setItemConnections(toObject: object)
        case .mainInfo:
            mainInfoView.setItemConnections(toObject: object)
        case .listOfWorks:
            listOfWorksView.setItemConnections(toObject: object)
        case .histBackground:
            historicalBackgroundView.setItemConnections(toObject: object)
        case .additionalInfo:
            additionalInfoView.setItemConnections(toObject: object)
        }
    }
   
}
