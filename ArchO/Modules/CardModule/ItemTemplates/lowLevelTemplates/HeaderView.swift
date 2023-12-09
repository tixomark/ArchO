//
//  ListItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

class HeaderView: UIView, ItemIdentifiable {
    private var numberLabel, titleLabel: UILabel!
    private var backgroundView = UIView()
    private var hintView = UIView()
    private var hint: String?
    private let padding: CGFloat = 5
    
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: HeaderView.noIntrinsicMetric, height: 56)
    }
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        numberLabel = UILabel()
        numberLabel.layer.cornerRadius = 5
        numberLabel.backgroundColor = .archoSecondaryColor
        numberLabel.textColor = .archoBackgroundColor
        numberLabel.textAlignment = .center
        numberLabel.font = .systemFont(ofSize: 24)
        numberLabel.clipsToBounds = true
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.textColor = .archoSecondaryColor
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.numberOfLines = 0

        backgroundView.layer.cornerRadius = 5
        backgroundView.backgroundColor = .archoLightGray
        
        backgroundView.addSubviews(numberLabel, titleLabel)
        self.addSubviews(backgroundView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: numberLabel, titleLabel, backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            numberLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            numberLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            numberLabel.heightAnchor.constraint(equalToConstant: intrinsicContentSize.height - padding * 2),
            numberLabel.widthAnchor.constraint(equalTo: numberLabel.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(number: String, title: String, hint: String? = nil) {
        numberLabel.text = number
        titleLabel.text = title
    }


}
