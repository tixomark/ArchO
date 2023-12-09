//
//  FirstVC.swift
//  ArchO
//
//  Created by Tixon Markin on 24.11.2023.
//

import UIKit

protocol FirstVCInput: GenericViewInput, AnyObject {
    
}

class FirstVC: UIViewController {
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
    
    var textItem1 = TextItem()
    var dateItem2 = DateItem()
    var dateItem3 = DateItem()
    
    lazy var items: [UIView] = [textItem1, dateItem2, dateItem3]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        interactor.viewLoaded(.firstView)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    deinit {
        print("deinit FirstVC")
    }
}

// MARK: - setting ui and constraints
extension FirstVC {
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        textItem1.itemID = .item1
        dateItem2.itemID = .item2
        dateItem3.itemID = .item3
    
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

extension FirstVC: FirstVCInput {
    func populateItemswithData(_ itemsData: [ItemID : [PersistentDataContainer]], headersData: [PersistentDataContainer]) {
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
