//
//  ImageItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 15.10.2023.
//

import UIKit

class ItemLoadItem: UIView {
    var headerView = HeaderView()
    var itemView = ItemLoadView()
    
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
        let totalSpaceing = (itemView.spaceing) * CGFloat(itemView.numberOfItemsInRow) + itemView.spaceing
        
        itemView.itemWidth = (self.frame.width - totalSpaceing) / CGFloat(itemView.numberOfItemsInRow)
        setUpConstraints()
    }
    
    private func setUpUI() {
        self.addSubviews(headerView, itemView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, itemView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            
            itemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            itemView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ItemLoadItem: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.forEach { itemData in
            switch itemData {
            case let .header(number, title, hint):
                headerView.configure(number: number, title: title, hint: hint)
                headerView.itemID = itemID
            case .imageLoad:
                itemView.itemID = itemID
            case .fileLoad:
                itemView.itemID = itemID
                itemView.configure(loadType: .file)
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        itemView.delegate = (delegate as? ItemLoadViewDelegate)
        itemView.dataSource = (dataSource as? ItemLoadViewDataSource)
    }
}
