//
//  CombinedItem.swift
//  ArchO
//
//  Created by Tixon Markin on 23.10.2023.
//

import UIKit

class CombinedItem1: UIView {
    var headerView = HeaderView()
    var pickerView1 = PickerView()
    var pickerView2 = PickerView()
    var dateView = DateView()
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
        self.addSubviews(headerView, pickerView1, pickerView2, dateView, imageView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, pickerView1, pickerView2, dateView, imageView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            
            pickerView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            pickerView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            pickerView2.topAnchor.constraint(equalTo: pickerView1.bottomAnchor, constant: 8),
            pickerView2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dateView.topAnchor.constraint(equalTo: pickerView2.bottomAnchor, constant: 8),
            dateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension CombinedItem1: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.enumerated().forEach { index, itemData in
            switch itemData {
            case let .header(number, title, hint):
                headerView.configure(number: number, title: title, hint: hint)
                headerView.itemID = itemID
            case let .picker(annotation, options, initialOption, placementOrder):
                guard placementOrder != nil else { return }
                let picker = placementOrder == 0 ? pickerView1 : pickerView2
                picker.tag = placementOrder!
                picker.configure(text: initialOption, annotation: annotation, options: options)
                picker.itemID = itemID
            case let .date(annotation):
                dateView.configure(annotation: annotation)
                dateView.itemID = itemID
            case .imageLoad:
                imageView.itemID = itemID
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        pickerView1.delegate = (delegate as? PickerViewDelegate)
        pickerView2.delegate = (delegate as? PickerViewDelegate)
        dateView.delegate = (delegate as? DateViewDelegate)
        imageView.delegate = (delegate as? ItemLoadViewDelegate)
        
        imageView.dataSource = (dataSource as? ItemLoadViewDataSource)
    }
}
