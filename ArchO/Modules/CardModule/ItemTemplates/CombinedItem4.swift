//
//  CombinedItem4.swift
//  ArchO
//
//  Created by Tixon Markin on 23.10.2023.
//

import UIKit

class CombinedItem4: UIView {
    var headerView = HeaderView()
    var pickerView = PickerView()
    var imageView = ItemLoadView()
    var textView = TextView()
    
    var itemID: ItemID!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let totalSpaceing = (imageView.spaceing) * CGFloat(imageView.numberOfItemsInRow) + imageView.spaceing
        
        imageView.itemWidth = (self.frame.width - totalSpaceing) / CGFloat(imageView.numberOfItemsInRow)
        setUpConstraints()
    }
    
    private func setUpUI() {
        self.addSubviews(headerView, pickerView, imageView, textView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, pickerView, imageView, textView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            
            pickerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
           
            imageView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension CombinedItem4: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.enumerated().forEach { index, itemData in
            switch itemData {
            case let .header(number, title, hint):
                headerView.configure(number: number, title: title, hint: hint)
                headerView.itemID = itemID
            case let .picker(annotation, options, initialOption, _):
                pickerView.configure(text: initialOption, annotation: annotation, options: options)
                pickerView.itemID = itemID
            case .text(let placeholder, _):
                textView.configure(placeholder: placeholder)
                textView.itemID = itemID
            case .imageLoad:
                imageView.itemID = itemID
            case .fileLoad:
                imageView.itemID = itemID
                imageView.configure(loadType: .file)
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        pickerView.delegate = (delegate as? PickerViewDelegate)
        imageView.delegate = (delegate as? ItemLoadViewDelegate)
        textView.delegate = (delegate as? TextViewDelegate)
        
        imageView.dataSource = (dataSource as? ItemLoadViewDataSource)
    }
}
