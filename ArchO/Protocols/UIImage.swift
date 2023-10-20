//
//  ImageNames.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation
import UIKit

enum ImageName: String {
    case profileImage = "profileImage"
    case profileIcon = "profileIcon"
    case regIcon = "registrationIcon"
    case importIcom = "importIcon"
    case exclamationIcon = "exclamationIcon"
    
}

extension UIImage {
    convenience init?(_ name: ImageName) {
        self.init(named: name.rawValue)
    }
}
