//
//  ImageListItem.swift
//  ArchO
//
//  Created by Tixon Markin on 26.10.2023.
//

import UIKit

class ImageListItem: UIView {
    var headerView = HeaderView()
    var textView = TextView()
    var descImageLoadView = DescImageLoadView()
    
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
        self.addSubviews(headerView, textView, descImageLoadView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, textView, descImageLoadView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
           
            textView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            descImageLoadView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            descImageLoadView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            descImageLoadView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            descImageLoadView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
        ])
    }
}

extension ImageListItem: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.enumerated().forEach { index, itemData in
            switch itemData {
            case let .header(number, title, hint):
                headerView.configure(number: number, title: title, hint: hint)
                headerView.itemID = itemID
            case .text(let placeholder, _):
                textView.configure(placeholder: placeholder)
                textView.itemID = itemID
            case let .describedImageLoad(label, placeholder) :
                descImageLoadView.configure(headerTitle: label, itemTextFieldPlaceholder: placeholder)
                descImageLoadView.itemID = itemID
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        textView.delegate = (delegate as? TextViewDelegate)
        descImageLoadView.delegate = (delegate as? DescImageLoadViewDelegate)
        
        descImageLoadView.dataSource = (dataSource as? DescImageLoadViewDataSource)
    }
}
