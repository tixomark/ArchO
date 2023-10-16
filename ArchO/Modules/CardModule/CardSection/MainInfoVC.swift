//
//  MainInfoVC.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

class MainInfoVC: UIViewController {
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = false
        scroll.maximumZoomScale = 1.0
        scroll.minimumZoomScale = 1.0
        return scroll
    }()
    
    var contentView: UIView!
    
    var header: SectionHeaderView!
    var textItem4: TextItemView!
    var textItem5: TextItemView!
    var textItem6: TextItemView!
    
    var imageItem7: ImageItemView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpConstraints()
    }

}

// MARK: - setting ui and constraints
extension MainInfoVC {
    private func setUpUI() {
        
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        let contentFrame = view.bounds.inset(by: .init(top: 8, left: 8, bottom: 8, right: 8))
        scrollView.contentSize = contentFrame.size
        
        contentView = UIView()
        contentView.frame = contentFrame
        scrollView.addSubview(contentView)
        
        header = SectionHeaderView()
        header.configure(title: "First header")
        contentView.addSubview(header)
        
        textItem4 = TextItemView()
        textItem4.header.configure(number: "4", title: "Some title")
        textItem4.textView.configure(placeholder: "Some placeholder", text: "Some text")
        contentView.addSubview(textItem4)
        
        textItem5 = TextItemView()
        textItem5.header.configure(number: "5", title: "Some title")
        textItem5.textView.configure(placeholder: "Some placeholder")
        contentView.addSubview(textItem5)
        
        imageItem7 = ImageItemView()
        imageItem7.header.configure(number: "7", title: "Some image title")
        imageItem7.imageView.presentingView = self
        contentView.addSubview(imageItem7)
        
    }
    
    private func setUpConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        header.translatesAutoresizingMaskIntoConstraints = false
        textItem4.translatesAutoresizingMaskIntoConstraints = false
        textItem5.translatesAutoresizingMaskIntoConstraints = false
        imageItem7.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            header.topAnchor.constraint(equalTo: contentView.topAnchor),
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            textItem4.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            textItem4.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textItem4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            textItem5.topAnchor.constraint(equalTo: textItem4.bottomAnchor, constant: 16),
            textItem5.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textItem5.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageItem7.topAnchor.constraint(equalTo: textItem5.bottomAnchor, constant: 16),
            imageItem7.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageItem7.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])

        
    }
}

