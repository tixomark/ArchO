//
//  ListItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

class HeaderView: UIView {
    var numberLabel, titleLabel: UILabel!
    private var backgroundView: UIView!
    var hintView: UIView!
    var hint: String?
   
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
        numberLabel.clipsToBounds = true
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        
        backgroundView = UIView()
        backgroundView.layer.cornerRadius = 5
        backgroundView.backgroundColor = .archoLightGray
        
        backgroundView.addSubviews(numberLabel, titleLabel)
        self.addSubviews(backgroundView)
    }
    
    private func setUpConstraints() {
        doNotTranslateAutoLayout(for: numberLabel, titleLabel, backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            numberLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            numberLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            numberLabel.widthAnchor.constraint(equalTo: numberLabel.heightAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(number: String, title: String, hint: String? = nil) {
        numberLabel.text = number
        titleLabel.text = title
        
    }


}
