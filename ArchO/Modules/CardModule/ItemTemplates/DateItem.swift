//
//  DateItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 18.10.2023.
//

import UIKit

class DateItem: UIView {
    var headerView = HeaderView()
    var dateView = DateView()
    
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
        self.addSubviews(headerView, dateView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: headerView, dateView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: self.topAnchor),
            
            dateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            dateView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}


extension DateItem: ItemProtocol {
    func configure(data: [PersistentDataContainer]) {
        data.forEach { itemData in
            switch itemData {
            case let .header(number, title, hint):
                headerView.configure(number: number, title: title, hint: hint)
                headerView.itemID = itemID
            case let .date(annotation):
                dateView.configure(annotation: annotation)
                dateView.itemID = itemID
            default:
                return
            }
        }
    }
    
    func assign(delegateTo delegate: AnyObject, dataSourceTo dataSource: AnyObject) {
        dateView.delegate = (delegate as? DateViewDelegate)
    }
}
