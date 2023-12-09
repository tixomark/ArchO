//
//  ItemProtocol.swift
//  ArchO
//
//  Created by Tixon Markin on 02.11.2023.
//

import Foundation

protocol ItemProtocol: ItemIdentifiable, ItemConfigurable {}

protocol ItemIdentifiable {
    var itemID: ItemID! { get set }
}

protocol ItemConfigurable {
    func configure(data: [PersistentDataContainer])
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject)
}

