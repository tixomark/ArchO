//
//  VariableData.swift
//  ArchO
//
//  Created by Tixon Markin on 15.11.2023.
//

import Foundation
import UIKit

class CardData {
    var texts: [ItemID: String] = [:]
    var dates: [ItemID: Date] = [:]
    var loadViewImages: [ItemID: [UIImage]] = [:]
    var loadViewFiles: [ItemID: [URL]] = [:]
    var pickerOptions: [ItemID: String] = [:]
    var descLoadViewItems: [ItemID: [DescribedItem]] = [:]
    
    struct DescribedItem {
        var image: UIImage?
        var description: String?
    }
}
