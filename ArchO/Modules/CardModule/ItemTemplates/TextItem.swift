//
//  TextItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 13.10.2023.
//

import UIKit

class TextItem: UIView {
    var header: HeaderView!
    var textView: TextView!
    
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
        textView = TextView()
        self.addSubviews(header, textView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: header, textView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.topAnchor.constraint(equalTo: self.topAnchor),
            
            textView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
