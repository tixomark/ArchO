//
//  SectionHeaderView.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

class SectionHeaderView: UIView {
    var titleLabel: UILabel!
    var backgroundView: UIView!
    
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
        return CGSize(width: SectionHeaderView.noIntrinsicMetric, height: 56)
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = .archoDarkGray
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .archoBackgroundColor
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        
        backgroundView = UIView()
        backgroundView.layer.cornerRadius = 5
        backgroundView.backgroundColor = .archoSecondaryColor
        
        backgroundView.addSubview(titleLabel)
        self.addSubview(backgroundView)
    }
    
    private func setUpConstraints() {
        doNotTranslateAutoLayout(for: titleLabel, backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }

}
