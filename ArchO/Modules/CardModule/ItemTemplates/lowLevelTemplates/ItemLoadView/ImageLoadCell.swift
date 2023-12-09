//
//  ImageCell.swift
//  ArchO
//
//  Created by Tixon Markin on 16.10.2023.
//

import UIKit

protocol ItemLoadCellDelegate: AnyObject {
    func didTapDeleteButtonIn(_ itemLoadCell: UICollectionViewCell)
}

class ImageLoadCell: UICollectionViewCell {
    private var imageView: UIImageView!
    private var deleteButton: UIButton!
    
    weak var delegate: ItemLoadCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 4),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor)
        ])
    }
    
    private func setUpUI() {
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView = UIImageView(frame: self.bounds)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        deleteButton = UIButton()
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        deleteButton.setImage(UIImage(.deleteIcon), for: .normal)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviews(imageView, deleteButton)
    }
    
    func configure(_ image: UIImage?, hideDeleteButton: Bool = false) {
        imageView.image = image ?? UIImage()
        deleteButton.isHidden = hideDeleteButton
    }
    
    @objc func didTapDeleteButton() {
        delegate?.didTapDeleteButtonIn(self)
    }
    
}
