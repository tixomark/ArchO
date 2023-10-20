//
//  ImageCell.swift
//  ArchO
//
//  Created by Tixon Markin on 16.10.2023.
//

import UIKit

class ImageCell: UICollectionViewCell {
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView = UIImageView(frame: self.bounds)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image ?? UIImage()
    }
    
}
