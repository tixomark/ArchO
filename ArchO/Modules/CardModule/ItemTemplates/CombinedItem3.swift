//
//  CombinedItem3.swift
//  ArchO
//
//  Created by Tixon Markin on 23.10.2023.
//

import UIKit

class CombinedItem3: UIView {
    var headerView = HeaderView()
    var pickerView = PickerView()
    var dateView = DateView()
    var textView = TextView()
    var imageView = ItemLoadView()
    
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
        self.addSubviews(headerView, pickerView, dateView, textView, imageView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, pickerView, dateView, textView, imageView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            
            pickerView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dateView.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 8),
            dateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
           
            textView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension CombinedItem3: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.enumerated().forEach { index, itemData in
            switch itemData {
            case let .header(number, title, hint):
                headerView.configure(number: number, title: title, hint: hint)
                headerView.itemID = itemID
            case let .picker(annotation, options, initialOption, _):
                pickerView.configure(text: initialOption, annotation: annotation, options: options)
                pickerView.itemID = itemID
            case let .date(annotation):
                dateView.configure(annotation: annotation)
                dateView.itemID = itemID
            case .text(let placeholder, _):
                textView.configure(placeholder: placeholder)
                textView.itemID = itemID
            case .imageLoad:
                imageView.itemID = itemID
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        pickerView.delegate = (delegate as? PickerViewDelegate)
        dateView.delegate = (delegate as? DateViewDelegate)
        textView.delegate = (delegate as? TextViewDelegate)
        imageView.delegate = (delegate as? ItemLoadViewDelegate)
        
//        pickerView.dataSource = (dataSource as? PickerViewDataSource)
        imageView.dataSource = (dataSource as? ItemLoadViewDataSource)
    }
}

