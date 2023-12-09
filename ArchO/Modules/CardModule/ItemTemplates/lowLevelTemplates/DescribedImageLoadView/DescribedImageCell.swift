//
//  DescribedImageCell.swift
//  ArchO
//
//  Created by Tixon Markin on 23.10.2023.
//

import Foundation
import UIKit

protocol DescribedImageViewDelegate: AnyObject {
    func didSelect(_ imageView: DescribedImageView)
    func textDidChangeIn(_ imageView: DescribedImageView, text: String)
    func didTapDeleteButonIn(_ imageView: DescribedImageView)
}

class DescribedImageView: UIView {
    private var mainImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        image.layer.borderWidth = 1.5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        return image
    }()
    private var textView = TextView()
    private var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(.deleteIcon), for: .normal)
        return button
    }()
    
    weak var delegate: DescribedImageViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    deinit {
        print("Deinit DescImageView")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        backgroundColor = .archoBackgroundColor
        
        textView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        mainImage.addGestureRecognizer(tapGesture)
        
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        
        addSubviews(mainImage, textView, deleteButton)
    }
    
    private func setUpConstraints() {
        DescribedImageView.doNotTranslateAutoLayout(for: mainImage, textView, deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: self.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalTo: deleteButton.heightAnchor),
            
            mainImage.topAnchor.constraint(equalTo: self.topAnchor),
            mainImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainImage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            
            textView.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func configure(image: UIImage?, description text: String?, placeholder: String?) {
        mainImage.image = image
        textView.configure(placeholder: placeholder, text: text)
    }
    
    @objc private func didTapImageView() {
        delegate?.didSelect(self)
    }
    
    @objc private func didTapDeleteButton() {
        delegate?.didTapDeleteButonIn(self)
    }
}

extension DescribedImageView: TextViewDelegate {
    func textDidEndEditingIn(_ textView: TextView) {
        
    }
    
    func textDidChangeIn(_ textView: TextView, text: String) {
        delegate?.textDidChangeIn(self, text: text)
    }
    
    
}
