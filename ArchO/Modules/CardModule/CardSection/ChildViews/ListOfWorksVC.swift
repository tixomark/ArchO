//
//  ListOfWorksVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.10.2023.
//

import UIKit

protocol ListOfWorksVCInput: GenericViewInput, AnyObject {
    
}

class ListOfWorksVC: UIViewController {
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
    
    var headerItem = SectionHeaderItem()
    var combinedItem18 = CombinedItem1()
    var combinedItem19 = CombinedItem2()
    var combinedItem20 = CombinedItem3()
    var combinedItem21 = CombinedItem3()
    var combinedItem22 = CombinedItem3()
    var combinedItem23 = CombinedItem4()
    
    lazy var items: [UIView] = [headerItem, combinedItem18, combinedItem19, combinedItem20, combinedItem21, combinedItem22, combinedItem23]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        interactor.viewLoaded(.listOfWorks)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    deinit {
        print("deinit ListOfWorksVC")
    }
}

// MARK: - setting ui and constraints
extension ListOfWorksVC {
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        combinedItem18.itemID = .item18()
        combinedItem19.itemID = .item19()
        combinedItem20.itemID = .item20
        combinedItem21.itemID = .item21
        combinedItem22.itemID = .item22
        combinedItem23.itemID = .item23
        
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

extension ListOfWorksVC: ListOfWorksVCInput {
    func populateItemswithData(_ itemsData: [ItemID : [PersistentDataContainer]],
                               headersData: [PersistentDataContainer]) {
        headerItem.configure(data: headersData)
        
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

