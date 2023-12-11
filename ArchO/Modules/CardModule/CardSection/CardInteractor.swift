//
//  CardInteractor.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import Foundation
import UIKit

protocol CardInteractorInput: AnyObject {
    func viewLoaded(_ view: Views)
    func didTapCreateCardButton()
}

extension CardInteractor: ServiceObtainable {
    var neededServices: [Service] {
        [.cardManager, .auth, .userManager]
    }
    
    func addServices(_ services: [Service : ServiceProtocol]) {
        cardManager = (services[.cardManager] as! DBCardManagerProtocol)
        auth = (services[.auth] as! FBAuthProtocol)
        userManager = (services[.userManager] as! DBUserManagerProtocol)
    }
}

class CardInteractor {
    var presenter: CardPresenterInput!
    var cardManager: DBCardManagerProtocol!
    var auth: FBAuthProtocol!
    var userManager: DBUserManagerProtocol!
    
    var variableData = CardData()
    
    deinit {
        print("deinit CardInteractor")
    }
}

extension CardInteractor: CardInteractorInput {
    func didTapCreateCardButton() {
        guard let ownerID = auth.curentUserID else {
            print("CardInteractor.didTapCreateCardButton: No authenticated user")
            return
        }
        Task(priority: .userInitiated) {
            let createdCardID = await self.cardManager.loadCardToDB(variableData, ownerID: ownerID)
            
            print(createdCardID ?? "")
            guard let createdCardID else { return }
            await userManager.addCard(createdCardID, forUser: ownerID)
        }
    }
    
    func viewLoaded(_ view: Views) {
        presenter.setDataFor(view)
        presenter.setDelegatesOfItems(inView: view, toObject: self)
    }
    
}

extension CardInteractor: TextViewDelegate {
    func textDidChangeIn(_ textView: TextView, text: String) {
        guard var itemID = textView.itemID else { return }
        if case .item19 = itemID {
            itemID = ItemID.item19(id: textView.tag)
        }
        variableData.texts[itemID] = text
    }
    
    func textDidEndEditingIn(_ textView: TextView) {
        print("didEndEditing")
    }
}

extension CardInteractor: DateViewDelegate {
    func dateView(_ dateView: DateView, dateDidChangeTo date: Date) {
        variableData.dates[dateView.itemID] = date
    }
}

extension CardInteractor: ItemLoadViewDelegate, ItemLoadViewDataSource {
    func itemLoadView(_ itemLoadView: ItemLoadView, didAppendItemsWithImages images: [UIImage]) {
        guard let id = itemLoadView.itemID else { return }
        if variableData.loadViewImages[id] == nil {
            variableData.loadViewImages[id] = []
        }
        variableData.loadViewImages[id]?.append(contentsOf: images)
    }
    
    func itemLoadView(_ itemLoadView: ItemLoadView, didAppendItemsWithFiles urls: [URL]) {
        guard let id = itemLoadView.itemID else { return }
        if variableData.loadViewFiles[id] == nil {
            variableData.loadViewFiles[id] = []
        }
        variableData.loadViewFiles[id]?.append(contentsOf: urls)
        print(urls.map { $0.lastPathComponent })
    }
    
    func itemLoadView(_ itemLoadView: ItemLoadView, didRemoveItemAt index: Int) {
        switch itemLoadView.type {
        case .image:
            variableData.loadViewImages[itemLoadView.itemID]?.remove(at: index)
        case .file:
            variableData.loadViewFiles[itemLoadView.itemID]?.remove(at: index)
        }
    }
    
    func itemLoadView(_ itemLoadView: ItemLoadView, didSelectItemAt index: Int) {
        
    }
    
    func itemLoadView(numberOfItemsIn itemLoadView: ItemLoadView) -> Int {
        switch itemLoadView.type {
        case .image:
            variableData.loadViewImages[itemLoadView.itemID]?.count ?? 0
        case .file:
            variableData.loadViewFiles[itemLoadView.itemID]?.count ?? 0
        }
    }
    
    func itemLoadView(_ itemLoadView: ItemLoadView, imageForItemAt index: Int) -> UIImage? {
        variableData.loadViewImages[itemLoadView.itemID]?[index]
    }
    
    func itemLoadView(_ itemLoadView: ItemLoadView, textForItemAt index: Int) -> String? {
        variableData.loadViewFiles[itemLoadView.itemID]?[index].lastPathComponent
        
    }
    
}

extension CardInteractor: PickerViewDelegate {
    func pickerView(_ pickerView: PickerView, didSelectItem item: String) {
        guard var itemID = pickerView.itemID else { return }
        if case .item18 = itemID {
            itemID = ItemID.item18(id: pickerView.tag)
        }
        variableData.pickerOptions[itemID] = item
    }
}

extension CardInteractor: DescImageLoadViewDelegate, DescImageLoadViewDataSource {
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, imageDidChange image: UIImage, inItemAtIndex index: Int) {
        variableData.descLoadViewItems[descImageLoadView.itemID]?[index].image = image
    }
    
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, textDidChange text: String, inItemAt index: Int) {
        variableData.descLoadViewItems[descImageLoadView.itemID]?[index].description = text
    }
    
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, didAddItemAtIndex index: Int) {
        guard let id = descImageLoadView.itemID else { return }
        if variableData.descLoadViewItems[id] == nil {
            variableData.descLoadViewItems[id] = []
        }
        variableData.descLoadViewItems[id]?.insert(.init(), at: index)
    }
    
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, didRemoveItemAtIndex index: Int) {
        variableData.descLoadViewItems[descImageLoadView.itemID]?.remove(at: index)
    }
    
    func descImageLoadView(numberOfRowsIn descImageLoadView: DescImageLoadView) -> Int {
        variableData.descLoadViewItems[descImageLoadView.itemID]?.count ?? 0
    }
    
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, imageForRowAt index: Int) -> UIImage {
        variableData.descLoadViewItems[descImageLoadView.itemID]?[index].image ?? UIImage()
    }
    
    func descImageLoadView(_ descImageLoadView: DescImageLoadView, textForRowAt index: Int) -> String? {
        variableData.descLoadViewItems[descImageLoadView.itemID]?[index].description
    }
    
}

