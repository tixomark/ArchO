//
//  TableHeaderView.swift
//  ArchO
//
//  Created by Tixon Markin on 23.10.2023.
//

import UIKit

class TableHeaderView: UIView {
    var titleLabel: UILabel!
    private var backgroundView: UIView!
   
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
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: HeaderView.noIntrinsicMetric, height: 38)
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .archoSecondaryColor
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        
        backgroundView = UIView()
        backgroundView.layer.cornerRadius = 5
        backgroundView.backgroundColor = .archoLightGray
        
        self.addSubviews(backgroundView, titleLabel)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: titleLabel, backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }


}
