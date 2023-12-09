//
//  CombinedItem2.swift
//  ArchO
//
//  Created by Tixon Markin on 23.10.2023.
//

import UIKit

class CombinedItem2: UIView {
    var headerView = HeaderView()
    var pickerView = PickerView()
    var dateView = DateView()
    var textView1 = TextView()
    var textView2 = TextView()
    
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
        setUpConstraints()
    }
    
    private func setUpUI() {
        self.addSubviews(headerView, pickerView, dateView, textView1, textView2)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, pickerView, dateView, textView1, textView2)
        
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
           
            textView1.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 8),
            textView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            textView2.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 8),
            textView2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textView2.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension CombinedItem2: ItemProtocol {
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
            case let .text(placeholder, placementOrder):
                guard placementOrder != nil else { return }
                let textView = placementOrder == 0 ? textView1 : textView2
                textView.tag = placementOrder!
                textView.configure(placeholder: placeholder)
                textView.itemID = itemID
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        pickerView.delegate = (delegate as? PickerViewDelegate)
        textView1.delegate = (delegate as? TextViewDelegate)
        textView2.delegate = (delegate as? TextViewDelegate)
        dateView.delegate = (delegate as? DateViewDelegate)
        
//        pickerView.dataSource = (dataSource as? PickerViewDataSource)
    }
}
