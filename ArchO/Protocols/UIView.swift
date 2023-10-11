//
//  UIView.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
    
    func doNotTranslateAutolayout() {
        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
