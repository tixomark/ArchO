//
//  ImageItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 15.10.2023.
//

import UIKit

class ImageItemView: UIView {

    var header: HeaderView!
    var imageView: ImageLoadView!
    
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
        imageView = ImageLoadView()
        self.addSubviews(header, imageView)
        
    }
    
    private func setUpConstraints() {
        doNotTranslateAutoLayout(for: header, imageView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.topAnchor.constraint(equalTo: self.topAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
