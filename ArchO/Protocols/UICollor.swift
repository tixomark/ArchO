//
//  UICollor.swift
//  ArchO
//
//  Created by Tixon Markin on 14.07.2023.
//

import Foundation
import UIKit

extension UIColor {
    static var archoRed: UIColor {
        getColor("archoRed")
    }
    
    static var archoTurquoise: UIColor {
        getColor("archoTurquoise")
    }
    
    static var archoBackgroundColor: UIColor {
        getColor("archoBackgroundColor")
    }
    
    static var archoSecondaryColor: UIColor {
        getColor("archoSecondaryColor")
    }
    
    fileprivate static func getColor(_ named: String) -> UIColor {
        guard let color = UIColor(named: named) else {
            print("No such color \(named) in assets")
            return UIColor.clear
        }
        return color
    }
}
