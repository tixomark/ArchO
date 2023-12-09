//
//  FileLoadCell.swift
//  ArchO
//
//  Created by Tixon Markin on 27.11.2023.
//

import Foundation
import UIKit

class FileLoadCell: UICollectionViewCell {
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
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
        setUpConstraints()
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
        
        titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 8)
        titleLabel.textColor = .archoSecondaryColor
        
        
        contentView.addSubviews(imageView, deleteButton, titleLabel)
    }
    
    private func setUpConstraints() {
        FileLoadCell.doNotTranslateAutoLayout(for: imageView, deleteButton, titleLabel)
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: contentView.bounds.height / 4),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(_ image: UIImage?, title text: String?, hideDeleteButton: Bool = false) {
        imageView.image = image ?? UIImage()
        deleteButton.isHidden = hideDeleteButton
        titleLabel.text = text
    }
    
    @objc func didTapDeleteButton() {
        delegate?.didTapDeleteButtonIn(self)
    }
    
}
