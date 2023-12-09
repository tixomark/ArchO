//
//  AdditionalInfoVC.swift
//  ArchO
//
//  Created by Tixon Markin on 13.10.2023.
//

import UIKit

protocol AdditionalInfoVCInput: GenericViewInput, AnyObject {
    
}

class AdditionalInfoVC: UIViewController {
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
    var fileLoadItem27 = ItemLoadItem()
    var textItem28 = TextItem()
    var textItem29 = TextItem()
    
    lazy var items: [UIView] = [headerItem, fileLoadItem27, textItem28, textItem29]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        interactor.viewLoaded(.additionalInfo)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    deinit {
        print("deinit AdditionalInfoVC")
    }
}

// MARK: - setting ui and constraints
extension AdditionalInfoVC {
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        fileLoadItem27.itemID = .item27
        textItem28.itemID = .item28
        textItem29.itemID = .item29
        
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

extension AdditionalInfoVC: AdditionalInfoVCInput {
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
