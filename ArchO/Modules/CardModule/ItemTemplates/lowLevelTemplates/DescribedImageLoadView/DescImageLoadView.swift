//
//  DescImageLoadView.swift
//  ArchO
//
//  Created by Tixon Markin on 26.10.2023.
//

import UIKit
import PhotosUI

protocol DescImageLoadViewDelegate: AnyObject {
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, imageDidChange image: UIImage, inItemAtIndex index: Int)
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, textDidChange text: String, inItemAt index: Int)
    
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, didAddItemAtIndex index: Int)
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, didRemoveItemAtIndex index: Int)
}


protocol DescImageLoadViewDataSource: AnyObject {
    func descImageLoadView(numberOfRowsIn descImageLoadView: DescImageLoadView) -> Int
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, imageForRowAt index: Int) -> UIImage
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, textForRowAt index: Int) -> String?
}


class DescImageLoadView: UIView, ItemIdentifiable {
    var headerLabel = TableHeaderView()
    var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
        return stack
    }()
    var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.archoDarkGray.cgColor
        button.layer.borderWidth = 1.5
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setTitleColor(.archoDarkGray, for: .normal)
        return button
    }()
    private var imagePicker: ImagePicker?
    private var stackTopConstraint: NSLayoutConstraint!
    
    var limitOfItems: Int = 10
    private var remainingLimitOfItems: Int {
        limitOfItems - items.count
    }
    private var items: [DescribedImageView] = []
    private var itemTextFieldPlaceholder: String?
    var itemID: ItemID!
    
    weak var dataSource: DescImageLoadViewDataSource?
    weak var delegate: DescImageLoadViewDelegate?
    
    var selectedItem: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var layoutFirstTime = true
    override func layoutSubviews() {
        super.layoutSubviews()
        if layoutFirstTime {
            layoutFirstTime = false
            reloadList()
        }
        setUpConstraints()
    }
    
    private func setUpUI() {
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        self.addSubviews(headerLabel, stack, addButton)
    }
    
    @objc private func didTapAddButton() {
        insertItem()
    }
    
    func reloadList() {
        let newNumberOfItems = dataSource?.descImageLoadView(numberOfRowsIn: self) ?? 0
        let amountOfItemsToAdd = newNumberOfItems - items.count
        
        if amountOfItemsToAdd < 0 {
            (0..<abs(amountOfItemsToAdd)).forEach { _ in removeItem() }
        } else if amountOfItemsToAdd > 0 {
            (0..<abs(amountOfItemsToAdd)).forEach { _ in insertItem() }
        }
        
        let itemsToReload = Array(0..<items.count)
        reloadItems(at: itemsToReload)
    }
    
    func reloadItems(at indexes: [Int]) {
        indexes.forEach { index in
            guard index >= 0, index < items.count else {
                print("Index out of range. Trying to reload item \(index) while there are \(items.count) items")
                return
            }
            let image = dataSource?.descImageLoadView(self, imageForRowAt: index)
            let text = dataSource?.descImageLoadView(self, textForRowAt: index)
            items[index].configure(image: image, description: text, placeholder: itemTextFieldPlaceholder)
        }
    }
    
    func insertItem(at index: Int? = nil) {
        guard let inssertionIndex = index == nil ? items.count : index,
              inssertionIndex >= 0,
              inssertionIndex <= items.count
        else { return }
        
        let item = DescribedImageView()
        item.delegate = self
        items.insert(item, at: inssertionIndex)
        stack.insertArrangedSubview(item, at: inssertionIndex)
        item.configure(image: nil, description: nil, placeholder: itemTextFieldPlaceholder)
        delegate?.descImageLoadView(self, didAddItemAtIndex: inssertionIndex)
    }
    
    func removeItem(at index: Int? = nil) {
        guard let removalIndex = index == nil ? items.count - 1 : index,
                removalIndex >= 0,
              removalIndex < items.count
        else { return }
        let removedItem = items.remove(at: removalIndex)
        stack.removeArrangedSubview(removedItem)
        removedItem.removeFromSuperview()
        delegate?.descImageLoadView(self, didRemoveItemAtIndex: removalIndex)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerLabel, stack, addButton)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            addButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        if stackTopConstraint == nil {
            stackTopConstraint = stack.topAnchor.constraint(equalTo: headerLabel.bottomAnchor)
            stackTopConstraint.isActive = true
        }
        stackTopConstraint.constant = items.count == 0 ? 0 : 8
            
    }
    
    func configure(headerTitle title: String, itemTextFieldPlaceholder placeholder: String?) {
        headerLabel.configure(title: title)
        itemTextFieldPlaceholder = placeholder
    }
    
}

extension DescImageLoadView: DescribedImageViewDelegate {
    func didTapDeleteButonIn(_ imageView: DescribedImageView) {
        guard let index = items.firstIndex(of: imageView) else { return }
        removeItem(at: index)
    }
    
    func textDidChangeIn(_ imageView: DescribedImageView, text: String) {
        guard let index = items.firstIndex(of: imageView) else { return }
        delegate?.descImageLoadView(self, textDidChange: text, inItemAt: index)
    }
    
    func didSelect(_ imageView: DescribedImageView) {
        guard let index = items.firstIndex(of: imageView) else { return }
        if imagePicker == nil {
            imagePicker = ImagePicker(next: self)
        }
        imagePicker?.delegate = self
        imagePicker?.present(pickLimit: 1)
        selectedItem = index
    }
}

extension DescImageLoadView: ImagePickerDelegate {
    func imagePicker(_ picker: ImagePicker, didFinichPicking images: [UIImage]) {
        guard let image = images.first, selectedItem != nil else {
            print("'DescImageLoadView' no image from 'ImagePicker'")
            return
        }
        
        delegate?.descImageLoadView(self, imageDidChange: image, inItemAtIndex: selectedItem!)
        reloadItems(at: [selectedItem!])
    }
}


