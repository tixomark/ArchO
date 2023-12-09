//
//  GenericViewInput.swift
//  ArchO
//
//  Created by Tixon Markin on 06.11.2023.
//

import Foundation

protocol GenericViewInput {
    func populateItemswithData(_ itemsData: [ItemID: [PersistentDataContainer]], headersData: [PersistentDataContainer])
    func setItemConnections(toObject object: AnyObject)
}
