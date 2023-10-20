//
//  DateItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 18.10.2023.
//

import UIKit

class DateItem: UIView {
    var header: HeaderView!
    var dateView: DateView!
    
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
        dateView = DateView()
        self.addSubviews(header, dateView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: header, dateView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.topAnchor.constraint(equalTo: self.topAnchor),
            
            dateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dateView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            dateView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
