//
//  CardCell.swift
//  ArchO
//
//  Created by Tixon Markin on 18.08.2023.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {
    var titleLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel = UILabel()
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
