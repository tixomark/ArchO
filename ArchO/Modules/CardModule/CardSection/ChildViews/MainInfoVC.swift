//
//  MainInfoVC.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

protocol MainInfoVCInput: GenericViewInput, AnyObject {

}

class MainInfoVC: UIViewController {
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
    var textItem4 = TextItem()
    var textItem5 = TextItem()
    var textItem6 = TextItem()
    var imageItem7 = ItemLoadItem()
    var imageItem71 = ItemLoadItem()
    var textItem8 = TextItem()
    var dateItem9 = DateItem()
    var textItem10 = TextItem()
    var textItem11 = TextItem()
    var pickerItem12 = PickerItem()
    var pickerItem13 = PickerItem()
    var textItem14 = TextItem()
    var pickerItem15 = PickerItem()
    var textItem16 = TextItem()
    var textItem17 = TextItem()
    
    lazy var items: [UIView] = [headerItem, textItem4, textItem5, textItem6, imageItem7, imageItem71, textItem8, dateItem9, textItem10, textItem11, pickerItem12, pickerItem13, textItem14, pickerItem15, textItem16, textItem17]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        interactor.viewLoaded(.mainInfo)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    deinit {
        print("deinit MainInfoVC")
    }
}

// MARK: - setting ui and constraints
extension MainInfoVC {
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        textItem4.itemID = .item4
        textItem5.itemID = .item5
        textItem6.itemID = .item6
        imageItem7.itemID = .item7
        imageItem71.itemID = .item71
        textItem8.itemID = .item8
        dateItem9.itemID = .item9
        textItem10.itemID = .item10
        textItem11.itemID = .item11
        pickerItem12.itemID = .item12
        pickerItem13.itemID = .item13
        textItem14.itemID = .item14
        pickerItem15.itemID = .item15
        textItem16.itemID = .item16
        textItem17.itemID = .item17
    
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

extension MainInfoVC: MainInfoVCInput {
    func populateItemswithData(_ itemsData: [ItemID : [PersistentDataContainer]], headersData: [PersistentDataContainer]) {
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
