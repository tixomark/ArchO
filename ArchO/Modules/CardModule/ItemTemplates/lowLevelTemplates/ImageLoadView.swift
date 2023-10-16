//
//  ImageLoadView.swift
//  ArchO
//
//  Created by Tixon Markin on 15.10.2023.
//

import UIKit
import PhotosUI

class ImageLoadView: UIView {
    
    var collection: UICollectionView!
    var numberOfImages: Int = 0
    var spaceing: CGFloat = 8
    var numberOfItemsInRow: Int = 5
    var addImageButton: UIButton!
    var presentingView: UIViewController!
    
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: TextView.noIntrinsicMetric, height: 80)
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        let layout = UICollectionViewFlowLayout()
        let viewWidth = self.bounds.width
        let totalSpaceing = spaceing * CGFloat(numberOfItemsInRow + 1)
        let itemWidth = (viewWidth - totalSpaceing) / CGFloat(numberOfItemsInRow)
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.itemSize = itemSize
        layout.estimatedItemSize = itemSize
        layout.minimumInteritemSpacing = spaceing
        layout.minimumLineSpacing = spaceing
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .green
        self.addSubview(collection)
        
        addImageButton = UIButton()
        addImageButton.setBackgroundImage(UIImage(named: IN.importIcom.rawValue), for: .normal)
        addImageButton.clipsToBounds = true
        addImageButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        self.addSubview(addImageButton)
        
    
    }
    
    private func setUpConstraints() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        addImageButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.topAnchor),
            collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            addImageButton.topAnchor.constraint(equalTo: self.topAnchor),
            addImageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            addImageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addImageButton.widthAnchor.constraint(equalTo: addImageButton.heightAnchor)
        ])
    }
    
    @objc private func showImagePicker() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = 10
        let picker = PHPickerViewController(configuration: config)
        
        picker.delegate = self
        presentingView?.present(picker, animated: true)
    }
    
    func configure() {
    
    }
    

}

extension ImageLoadView: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
    }
    
    
    
}
