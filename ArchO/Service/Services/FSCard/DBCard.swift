//
//  Card.swift
//  ArchO
//
//  Created by Tixon Markin on 01.11.2023.
//

import Foundation
import UIKit

struct DBCard: Codable {
    
    // MARK:  ITEMS 1-3
    var fullName: String?
    var cardCreationDate: Date?
    var cardUpdateDate: Date?
    
    // MARK: ITEMS 3-7, 7(1), 8-17
    var name: String?
    var compositionOfPlaceAndParkEnsemble: String?
    var address: String?
    var modernViewOKN: [String]?
    var initialViewOKN: [String]?
    var coordinates: String?
    var constructionDate: Date?
    var architectors: String?
    var ownersInfo: String?
    var typologicalAffiliation: TypologicalAffilation?
    var protectedStatusOKN: ProtectedStatusOKN?
    var briefArchDescription: String?
    var tecnicalCondition: TecnicalCondition?
    var moderUsegeNature: String?
    var necessaryPriorityWorks: String?
    
    // MARK: ITEMS 18-23
    var photofixation: Photofixation?
    var historicalBackground: HistoricalBackground?
    var photogrammetry: Photogrammetry?
    var scanning3D: Scanning3D?
    var reconstruction3D: Reconstruction3D?
    var compilationOKN: CompilationOKN?
    
    // MARK: ITEMS 24-26
    var briefHistoricalBackground: BriefHistoricalBackground?
    var usedLiterature: String?
    var descriptionOKN: DescriptionOKN?
    
    // MARK: ITEMS 27-29
    var documents: [String]?
    var preservationProposials: String?
    var comments: String?
}
extension DBCard {
    init(from data: CardData) {
        // MARK:  ITEMS 1-3
        fullName = data.texts[.item1]
        cardCreationDate = data.dates[.item2]
        cardUpdateDate = data.dates[.item3]
        
        // MARK: ITEMS 3-7, 7(1), 8-17
        name = data.texts[.item4]
        compositionOfPlaceAndParkEnsemble = data.texts[.item5]
        address = data.texts[.item6]
        coordinates = data.texts[.item8]
        constructionDate = data.dates[.item9]
        architectors = data.texts[.item10]
        ownersInfo = data.texts[.item11]
        let affilationRV = data.pickerOptions[.item12] ?? ""
        typologicalAffiliation = TypologicalAffilation(rawValue: affilationRV)
        let protStatusRV = data.pickerOptions[.item13] ?? ""
        protectedStatusOKN = ProtectedStatusOKN(rawValue: protStatusRV)
        briefArchDescription = data.texts[.item14]
        let techCondRV = data.pickerOptions[.item13] ?? ""
        tecnicalCondition = TecnicalCondition(rawValue: techCondRV)
        moderUsegeNature = data.texts[.item16]
        necessaryPriorityWorks = data.texts[.item17]
        
        // MARK: ITEMS 18-23
        photofixation = Photofixation(data)
        historicalBackground = HistoricalBackground(data)
        photogrammetry = Photogrammetry(data)
        scanning3D = Scanning3D(data)
        reconstruction3D = Reconstruction3D(data)
        compilationOKN = CompilationOKN(data)
        
        // MARK: ITEMS 24-26
        briefHistoricalBackground = BriefHistoricalBackground(data)
        usedLiterature = data.texts[.item25]
        descriptionOKN = DescriptionOKN(data)
        
        // MARK: ITEMS 27-29
        preservationProposials = data.texts[.item28]
        comments = data.texts[.item29]
    }
    
    mutating func insertAttachements(_ data: [ItemID: [String]]) {
        modernViewOKN = data[.item7]
        initialViewOKN = data[.item71]
        
        photofixation?.graficImage = data[.item18()]
        photogrammetry?.graficImage = data[.item20]
        scanning3D?.graficImage = data[.item21]
        reconstruction3D?.graficImage = data[.item22]
        compilationOKN?.fileOKN = data[.item23]
        
        if let iconography = data[.item24] {
            for (index, name) in iconography.enumerated() {
                briefHistoricalBackground?.iconography?[index].image = name
            }
        }
        if let iconography = data[.item26] {
            for (index, name) in iconography.enumerated() {
                descriptionOKN?.iconography?[index].image = name
            }
        }
        
        documents = data[.item27]
    }
}

struct Photofixation: Codable {
    var type: PhotoFixationKind?
    var stageOfWork: StageOfWork?
    var date: Date?
    var graficImage: [String]?
}
extension Photofixation {
    init(_ data: CardData) {
        let typeRV = data.pickerOptions[.item18(id: 0)] ?? ""
        type = PhotoFixationKind(rawValue: typeRV)
        let stageOfWorkRV = data.pickerOptions[.item18(id: 1)] ?? ""
        stageOfWork = StageOfWork(rawValue: stageOfWorkRV)
        date = data.dates[.item18()]
    }
}

struct HistoricalBackground: Codable {
    var stageOfWork: StageOfWork?
    var date: Date?
    var linkToMaterial: String?
    var comment: String?
}
extension HistoricalBackground {
    init(_ data: CardData) {
        let stageOfWorkRV = data.pickerOptions[.item19()] ?? ""
        stageOfWork = StageOfWork(rawValue: stageOfWorkRV)
        date = data.dates[.item19()]
        linkToMaterial = data.texts[.item19(id: 0)]
        comment = data.texts[.item19(id: 1)]
    }
}

struct Photogrammetry: Codable {
    var stageOfWork: StageOfWork?
    var date: Date?
    var linkToModel: String?
    var graficImage: [String]?
}
extension Photogrammetry {
    init(_ data: CardData) {
        let stageOfWorkRV = data.pickerOptions[.item20] ?? ""
        stageOfWork = StageOfWork(rawValue: stageOfWorkRV)
        date = data.dates[.item20]
        linkToModel = data.texts[.item20]
    }
}

struct Scanning3D: Codable {
    var stageOfWork: StageOfWork?
    var date: Date?
    var linkToMaterial: String?
    var graficImage: [String]?
}
extension Scanning3D {
    init(_ data: CardData) {
        let stageOfWorkRV = data.pickerOptions[.item21] ?? ""
        stageOfWork = StageOfWork(rawValue: stageOfWorkRV)
        date = data.dates[.item21]
        linkToMaterial = data.texts[.item21]
    }
}

struct Reconstruction3D: Codable {
    var stageOfWork: StageOfWork?
    var date: Date?
    var linkToMaterial: String?
    var graficImage: [String]?
}
extension Reconstruction3D {
    init(_ data: CardData) {
        let stageOfWorkRV = data.pickerOptions[.item22] ?? ""
        stageOfWork = StageOfWork(rawValue: stageOfWorkRV)
        date = data.dates[.item22]
        linkToMaterial = data.texts[.item22]
    }
}

struct CompilationOKN: Codable {
    var stageOfWork: StageOfWork?
    var fileOKN: [String]?
    var comment: String?
}
extension CompilationOKN {
    init(_ data: CardData) {
        let stageOfWorkRV = data.pickerOptions[.item22] ?? ""
        stageOfWork = StageOfWork(rawValue: stageOfWorkRV)
        comment = data.texts[.item19(id: 1)]
    }
}

struct BriefHistoricalBackground: Codable {
    var historyDescription: String?
    var iconography: [IconographyItem]?
}
extension BriefHistoricalBackground {
    init(_ data: CardData) {
        historyDescription = data.texts[.item24]
        guard let itemsData = data.descLoadViewItems[.item24] else { return }
        iconography = []
        for item in itemsData {
            let ICItem = IconographyItem(comment: item.description)
            iconography?.append(ICItem)
        }
    }
}

struct DescriptionOKN: Codable {
    var currentState: String?
    var iconography: [IconographyItem]?
}
extension DescriptionOKN {
    init(_ data: CardData) {
        currentState = data.texts[.item26]
        guard let itemsData = data.descLoadViewItems[.item26] else { return }
        iconography = []
        for item in itemsData {
            let ICItem = IconographyItem(comment: item.description)
            iconography?.append(ICItem)
        }
    }
}

struct IconographyItem: Codable {
    var image: String?
    var comment: String?
}

