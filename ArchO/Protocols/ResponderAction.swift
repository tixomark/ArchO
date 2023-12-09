//
//  ResponderAction.swift
//  ArchO
//
//  Created by Tixon Markin on 27.11.2023.
//

import Foundation

@objc protocol PickerProtocol {
}

@objc protocol ResponderAction {
    func showPicker(_ picker: PickerProtocol)
}
