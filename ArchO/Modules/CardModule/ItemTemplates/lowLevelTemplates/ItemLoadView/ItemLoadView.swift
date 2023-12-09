//
//  ImageLoadView.swift
//  ArchO
//
//  Created by Tixon Markin on 15.10.2023.
//

import UIKit

enum ItemLoadViewType {
    case image, file
}

protocol ItemLoadViewDelegate: AnyObject {
    func itemLoadView(_ itemLoadView: ItemLoadView, didSelectItemAt index: Int)
    func itemLoadView(_ itemLoadView: ItemLoadView, didAppendItemsWithImages images: [UIImage])
    func itemLoadView(_ itemLoadView: ItemLoadView, didRemoveItemAt index: Int)
    func itemLoadView(_ itemLoadView: ItemLoadView, didAppendItemsWithFiles urls: [URL])
}

protocol ItemLoadViewDataSource: AnyObject {
    func itemLoadView(numberOfItemsIn itemLoadView: ItemLoadView) -> Int
    func itemLoadView(_ itemLoadView: ItemLoadView, imageForItemAt index: Int) -> UIImage?
    func itemLoadView(_ itemLoadView: ItemLoadView, textForItemAt index: Int) -> String?
}

class ItemLoadView: UIView, ItemIdentifiable {
    private var collection: UICollectionView!
    private var layout: UICollectionViewFlowLayout!
    private var remainingLimitOfItems: Int!
    private var itemHeightConstraint: NSLayoutConstraint!
    
    var limitOfItems: Int = 10
    var numberOfItemsInRow: Int = 5
    var spaceing: CGFloat = 8
    var itemWidth: CGFloat = 40
    
    private var currentHeight: CGFloat {
        var height = itemWidth + spaceing * 2
        guard let itemsCount = dataSource?.itemLoadView(numberOfItemsIn: self) else {
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
    
    var itemID: ItemID! 
    private(set) var type: ItemLoadViewType = .image
    
    private var imagePicker: ImagePicker?
    private var filePicker: FilePicker?
    
    weak var dataSource: ItemLoadViewDataSource?
    weak var delegate: ItemLoadViewDelegate?
    
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
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = spaceing
        layout.minimumLineSpacing = spaceing
        layout.sectionInset = UIEdgeInsets(top: spaceing, left: spaceing, bottom: spaceing, right: spaceing)
        collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.bounces = false
        collection.register(ImageLoadCell.self, forCellWithReuseIdentifier: ImageLoadCell.description())
        collection.register(FileLoadCell.self, forCellWithReuseIdentifier: FileLoadCell.description())
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
        
        if itemHeightConstraint == nil {
            itemHeightConstraint = self.heightAnchor.constraint(equalToConstant: currentHeight)
            itemHeightConstraint.isActive = true
        }
    }
    
    func configure(loadType: ItemLoadViewType) {
        type = loadType
    }
    
    func reload() {
        collection.reloadData()
    }
    
    func reloadItems(at indexes: [Int]) {
        let indexPaths: [IndexPath] = indexes.map { index in
            .init(item: index + 1, section: 0)
        }
        collection.reloadItems(at: indexPaths)
    }
    
    func insertItems(at indexes: [Int]?) {
        if let indexes = indexes {
            let indexPaths = indexes.map { index in
                IndexPath(item: index, section: 0)
            }
            collection.insertItems(at: indexPaths)
        }
    }
    
    func removeItem(at index: Int? = nil) {
        if let index = index {
            collection.deleteItems(at: [.init(item: index, section: 0)])
        } else {
            let lastIndex = collection.numberOfItems(inSection: 0) - 1
            let indexPath = IndexPath(item: lastIndex, section: 0)
            collection.deleteItems(at: [indexPath])
        }
        remainingLimitOfItems += 1
    }
    
    private func addItems(amount: Int) {
        remainingLimitOfItems -= amount
        let itemsAmount = collection.numberOfItems(inSection: 0)
        let indexesToInsert = (itemsAmount..<(itemsAmount + amount)).map { $0 }
        insertItems(at: indexesToInsert)
        
        itemHeightConstraint.constant = currentHeight
    }
}

extension ItemLoadView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        indexPath.item == 0 ? false : true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item == 0, remainingLimitOfItems > 0 else { return }
        switch type {
        case .image:
            if imagePicker == nil {
                imagePicker = .init(next: self)
            }
            imagePicker?.delegate = self
            imagePicker?.present(pickLimit: remainingLimitOfItems)
        case .file:
            if filePicker == nil {
                filePicker = .init(next: self)
            }
            filePicker?.delegate = self
            filePicker?.present(pickLimit: remainingLimitOfItems)
        }
        delegate?.itemLoadView(self, didSelectItemAt: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: itemWidth, height: itemWidth)
    }
}

extension ItemLoadView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let numbeOfItems = dataSource?.itemLoadView(numberOfItemsIn: self) {
            remainingLimitOfItems = limitOfItems - numbeOfItems
            return numbeOfItems + 1
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageLoadCell.description(), for: indexPath) as! ImageLoadCell
            cell.configure(.init(.importIcom), hideDeleteButton: true)
            return cell
        }
        
        switch type {
        case .image:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageLoadCell.description(), for: indexPath) as! ImageLoadCell
            let image = dataSource?.itemLoadView(self, imageForItemAt: indexPath.item - 1)
            cell.configure(image)
            cell.delegate = self
            return cell
        case .file:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FileLoadCell.description(), for: indexPath) as! FileLoadCell
            let image = dataSource?.itemLoadView(self, imageForItemAt: indexPath.item - 1)
            let text = dataSource?.itemLoadView(self, textForItemAt: indexPath.item - 1)
            cell.configure(image, title: text)
            cell.delegate = self
            return cell
        }
    }
}

extension ItemLoadView: ImagePickerDelegate {
    func imagePicker(_ picker: ImagePicker, didFinichPicking images: [UIImage]) {
        delegate?.itemLoadView(self, didAppendItemsWithImages: images)
        addItems(amount: images.count)
    }
    
}

extension ItemLoadView: FilePickerDelegate {
    func filePicker(_ picker: FilePicker, didFinichPickingFiles urls: [URL]) {
        delegate?.itemLoadView(self, didAppendItemsWithFiles: urls)
        addItems(amount: urls.count)
    }
}

extension ItemLoadView: ItemLoadCellDelegate {
    func didTapDeleteButtonIn(_ itemLoadCell: UICollectionViewCell) {
        guard let indexPathToRemove = collection.indexPath(for: itemLoadCell) else { return }
        delegate?.itemLoadView(self, didRemoveItemAt: indexPathToRemove.item - 1)
        removeItem(at: indexPathToRemove.item)
        
        itemHeightConstraint.constant = currentHeight
    }
}

