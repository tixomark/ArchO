//
//  DBCardInfo.swift
//  ArchO
//
//  Created by Tixon Markin on 11.12.2023.
//

import Foundation
import Firebase

struct DBCardInfo: Codable {
    var id: String?
    var creationDate: Timestamp?
    var updateDate: Timestamp?
    var title: String?
    var owner: String?
    var contributors: [String]?
    
}

extension DBCardInfo {
    init(id: String, ownerID: String, card: CardData) {
        self.id = id
        self.creationDate = Timestamp()
        self.updateDate = Timestamp()
        self.title = card.getTitle()
        self.owner = ownerID
        self.contributors = []
        
    }
}
