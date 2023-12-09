//
//  CaseIterable.swift
//  ArchO
//
//  Created by Tixon Markin on 29.11.2023.
//

import Foundation

extension CaseIterable where Self: RawRepresentable, RawValue == String {
    static var allValues: [String] {
        allCases.map { $0.rawValue }
    }
}
