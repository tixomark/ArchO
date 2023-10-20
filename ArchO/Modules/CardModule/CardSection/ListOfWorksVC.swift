//
//  ListOfWorksVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.10.2023.
//

import UIKit

class ListOfWorksVC: UIViewController {
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.bounces = false
        scroll.maximumZoomScale = 1.0
        scroll.minimumZoomScale = 1.0
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        let viewv = UIView()//frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        viewv.backgroundColor = .green
        scrollView.addSubview(viewv)
        scrollView.contentSize.height = 1000
        
        
        UIView.doNotTranslateAutoLayout(for: scrollView, viewv)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewv.heightAnchor.constraint(equalToConstant: 300),
            viewv.widthAnchor.constraint(equalToConstant: 300)
            
        ])
        
        
    }
    
   
    
}
