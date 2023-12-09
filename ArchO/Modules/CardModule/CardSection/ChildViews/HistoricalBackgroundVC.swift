//
//  HistoricalBackgroundVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.10.2023.
//

import UIKit

protocol HistoricalBackgroundVCInput: GenericViewInput, AnyObject {
    
}

class HistoricalBackgroundVC: UIViewController {
    var interactor: CardInteractorInput!
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.bounces = false
        scroll.contentInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        scroll.keyboardDismissMode = .interactive
        return scroll
    }()
    
    var headerItem1 = SectionHeaderItem()
    var imageListItem24 = ImageListItem()
    var textItem25 = TextItem()
    var headerItem2 = SectionHeaderItem()
    var imageListItem26 = ImageListItem()
    
    lazy var items: [UIView] = [headerItem1, imageListItem24, textItem25, headerItem2, imageListItem26]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        interactor.viewLoaded(.histBackground)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    deinit {
        print("deinit HistoricalBackgroundVC")
    }
    
}

// MARK: - setting ui and constraints
extension HistoricalBackgroundVC {
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        imageListItem24.itemID = .item24
        textItem25.itemID = .item25
        imageListItem26.itemID = .item26
        
        scrollView.addSubviews(items)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        UIView.doNotTranslateAutoLayout(for: items)
        let lastIndex = items.count - 1
        for (index, item) in items.enumerated() {
            switch index {
            case 0:
                item.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
            case lastIndex:
                item.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16).isActive = true
                fallthrough
            default:
                item.topAnchor.constraint(equalTo: items[index - 1].bottomAnchor, constant: 16).isActive = true
            }
            NSLayoutConstraint.activate([
                item.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -16)
            ])
        }
    }
    
}

extension HistoricalBackgroundVC: HistoricalBackgroundVCInput {
    func populateItemswithData(_ itemsData: [ItemID : [PersistentDataContainer]], 
                               headersData: [PersistentDataContainer]) {
        headerItem1.configure(data: [headersData[0]])
        headerItem2.configure(data: [headersData[1]])
        
        items.forEach { item in
            guard let item = item as? ItemProtocol, let itemData = itemsData[item.itemID] else { return }
            item.configure(data: itemData)
        }
    }
    
    func setItemConnections(toObject object: AnyObject) {
        guard let object = object as? CardInteractor else { return }
        for item in items {
            (item as? ItemProtocol)?.assign(delegateTo: object, dataSourceTo: object)
        }
    }
}

