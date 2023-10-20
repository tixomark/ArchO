//
//  PickerItem.swift
//  ArchO
//
//  Created by Tixon Markin on 20.10.2023.
//

import UIKit

class PickerItem: UIView {
    var header: HeaderView!
    var pickerView: PickerView!
    
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
        header = HeaderView()
        pickerView = PickerView()
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
