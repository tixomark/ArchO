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
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
    
    static func doNotTranslateAutoLayout(for views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    static func doNotTranslateAutoLayout(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
    
    func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.removeArrangedSubview($0) }
    }
    
    func removeArrangedSubviews(_ views: UIView...) {
        views.forEach { self.removeArrangedSubview($0) }
    }
}
