//
//  ImageLoadView.swift
//  ArchO
//
//  Created by Tixon Markin on 15.10.2023.
//

import UIKit
import PhotosUI

protocol ImageLoadViewDelegate: AnyObject {
    func imageLoadView(_ imageLoadView: ImageLoadView, didFinishPicking images: [UIImage])
}

protocol ImageLoadViewDataSource: AnyObject {
    func imageLoadView(numberOfItemsIn imageLoadView: ImageLoadView) -> Int?
    func imageLoadView(_ imageLoadView: ImageLoadView, imageForItemAt index: Int) -> UIImage?
}

class ImageLoadView: UIView {
    var presentingView: UIViewController!
    private var collection: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var remainingLimitOfItems: Int!
    private var canUseImagePicker: Bool = true
    private var imageViewHeightConstraint: NSLayoutConstraint!
    
    var limitOfItems: Int = 10
    var numberOfItemsInRow: Int = 5
    var spaceing: CGFloat = 8
    var itemWidth: CGFloat = 40
    private var currentHeight: CGFloat {
        var height = itemWidth + spaceing * 2
        guard let itemsCount = dataSource?.imageLoadView(numberOfItemsIn: self) else {
            return height
        }
        var rowsCount = (itemsCount + 1) / numberOfItemsInRow
        let numberOfItemsInLastRow = (itemsCount + 1) % numberOfItemsInRow
        if numberOfItemsInLastRow != 0 {
            rowsCount += 1
        }
        height = (itemWidth + spaceing) * CGFloat(rowsCount) + spaceing
        return height
    }
    
    weak var dataSource: ImageLoadViewDataSource?
    weak var delegate: ImageLoadViewDelegate?
    
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
        return CGSize(width: TextView.noIntrinsicMetric, height: currentHeight)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
//        self.imageViewHeightConstraint.constant = self.currentHeight

    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        remainingLimitOfItems = limitOfItems
        
        layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spaceing
        layout.minimumLineSpacing = spaceing
        layout.sectionInset = UIEdgeInsets(top: spaceing, left: spaceing, bottom: spaceing, right: spaceing)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.bounces = false
        collection.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.description())
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .archoBackgroundColor
        self.addSubview(collection)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: collection)
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: self.topAnchor),
            collection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.trailingAnchor)])
        
        if imageViewHeightConstraint == nil {
            imageViewHeightConstraint = self.heightAnchor.constraint(equalToConstant: currentHeight)
            imageViewHeightConstraint.isActive = true
        }
    }
    
    func reload() {
        collection.reloadData()
    }
}

extension ImageLoadView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        indexPath.item == 0 ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item == 0 else { return }
        showImagePicker()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ImageLoadView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numbeOfItems = dataSource?.imageLoadView(numberOfItemsIn: self) {
            remainingLimitOfItems = limitOfItems - numbeOfItems
            return numbeOfItems + 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.description(), for: indexPath) as! ImageCell
        
        if indexPath.item == 0 {
            cell.setImage(.init(.importIcom))
        } else {
            let image = dataSource?.imageLoadView(self, imageForItemAt: indexPath.item - 1)
            cell.setImage(image)
        }
        return cell
    }
}


extension ImageLoadView: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        canUseImagePicker = false
        var images: [UIImage] = []
        
        let group = DispatchGroup()
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage {
                    images.append(image)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main, work: DispatchWorkItem(block: { [weak self] in
            guard let self = self else { return }
            delegate?.imageLoadView(self, didFinishPicking: images)
            let startIndex = collection.numberOfItems(inSection: 0)
            let endIndex = startIndex + images.count
            var indexes = [IndexPath]()
            for index in startIndex ..< endIndex {
                indexes.append(IndexPath(item: index, section: 0))
            }
            picker.dismiss(animated: true)
            collection.insertItems(at: indexes)
            self.imageViewHeightConstraint.isActive = false
                self.imageViewHeightConstraint.constant = self.currentHeight
            self.imageViewHeightConstraint.isActive = true
                self.setNeedsUpdateConstraints()
            canUseImagePicker = true
        }))
    }
    
    private func showImagePicker() {
        guard canUseImagePicker && remainingLimitOfItems > 0 else { return }
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .images
        config.selectionLimit = remainingLimitOfItems
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        presentingView?.present(picker, animated: true)
    }
}
