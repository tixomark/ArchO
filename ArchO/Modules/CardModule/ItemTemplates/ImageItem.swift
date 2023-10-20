//
//  ImageItemView.swift
//  ArchO
//
//  Created by Tixon Markin on 15.10.2023.
//

import UIKit

protocol ImageItemDelegate: AnyObject {
    func imageItem(_ imageItem: ImageItem, didFinishPicking images: [UIImage])
}

protocol ImageItemDataSource: AnyObject {
    func imageItem(numberOfItemsIn imageItem: ImageItem) -> Int?
    func imageItem(_ imageItem: ImageItem, imageForItemAt index: Int) -> UIImage
}

class ImageItem: UIView {
    var header: HeaderView!
    var imageView: ImageLoadView!

    weak var delegate: ImageItemDelegate?
    weak var dataSource: ImageItemDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let totalSpaceing = (imageView.spaceing) * CGFloat(imageView.numberOfItemsInRow) + imageView.spaceing
        
        imageView.itemWidth = (self.frame.width - totalSpaceing) / CGFloat(imageView.numberOfItemsInRow)
        setUpConstraints()
    }
    
    private func setUpUI() {
        header = HeaderView()
        imageView = ImageLoadView()
        imageView.delegate = self
        imageView.dataSource = self
        imageView.clipsToBounds = true
        imageView.numberOfItemsInRow = 5
        
        self.addSubviews(header, imageView)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: header, imageView)
        
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            header.topAnchor.constraint(equalTo: self.topAnchor),
            
            imageView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ImageItem: ImageLoadViewDelegate, ImageLoadViewDataSource {
    func imageLoadView(_ imageLoadView: ImageLoadView, didFinishPicking images: [UIImage]) {
        delegate?.imageItem(self, didFinishPicking: images)
    }
    
    func imageLoadView(numberOfItemsIn imageLoadView: ImageLoadView) -> Int? {
        dataSource?.imageItem(numberOfItemsIn: self)
    }
    
    func imageLoadView(_ imageLoadView: ImageLoadView, imageForItemAt index: Int) -> UIImage? {
        dataSource?.imageItem(self, imageForItemAt: index)
    }
    
}
