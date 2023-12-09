//
//  Identifiers.swift
//  ArchO
//
//  Created by Tixon Markin on 29.11.2023.
//

import Foundation

enum Views: Int {
    case firstView, mainInfo, listOfWorks, histBackground, additionalInfo
}

enum ItemID: Hashable {
    case item1// = "fullName"
    case item2// = "cardCreationDate"
    case item3// = "cardUpdateDate"
    
    case item4// = "name"
    case item5// = "compositionOfPlaceAndParkEnsemble"
    case item6// = "address"
    case item7// = "modernViewOKN"
    case item71// = "initialViewOKN"
    case item8// = "coordinates"
    case item9// = "constructionDate"
    case item10// = "architectors"
    case item11// = "ownersInfo"
    case item12// = "typologicalAffiliation"
    case item13// = "protectedStatusOKN"
    case item14// = "briefArchDescription"
    case item15// = "tecnicalCondition"
    case item16// = "moderUsageNature"
    case item17// = "necessaryPriorityWorks"
    
    case item18(id: Int? = nil)// = "photofixation"
    case item19(id: Int? = nil)// = "historicalBackground"
    case item20// = "photogrammetry"
    case item21// = "scanning3D"
    case item22// = "reconstruction3D"
    case item23// = "compilationOKN"
    
    case item24// = "briefHistoricalBackground"
    case item25// = "usedLiterature"
    case item26// = "OKN"
    
    case item27// = "documents"
    case item28// = "preservationProposials"
    case item29// = "comments"
    
}
