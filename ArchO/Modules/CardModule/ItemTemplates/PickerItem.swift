//
//  PickerItem.swift
//  ArchO
//
//  Created by Tixon Markin on 20.10.2023.
//

import UIKit

class PickerItem: UIView {
    var header = HeaderView()
    var pickerView = PickerView()
    
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
        self.addSubviews(header, pickerView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: header, pickerView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.topAnchor.constraint(equalTo: self.topAnchor),
            
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pickerView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension PickerItem: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.forEach { itemData in
            switch itemData {
            case let .header(number, title, hint):
                header.configure(number: number, title: title, hint: hint)
                header.itemID = itemID
            case let .picker(annotation, options, initialOption, _):
                pickerView.configure(text: initialOption, annotation: annotation, options: options)
                pickerView.itemID = itemID
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        pickerView.delegate = (delegate as? PickerViewDelegate)
    }
}
