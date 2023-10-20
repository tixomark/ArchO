//
//  MainInfoVC.swift
//  ArchO
//
//  Created by Tixon Markin on 12.10.2023.
//

import UIKit

class MainInfoVC: UIViewController {
    var images: [UIImage] = []
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
    var imageItem7 = ImageItem()
    var imageItem71 = ImageItem()
    var textItem8 = TextItem()
    var textItem9 = DateItem()
    var textItem10 = TextItem()
    var textItem11 = TextItem()
    var pickerItem12 = PickerItem()
    var pickerItem13 = PickerItem()
    var textItem14 = TextItem()
    var pickerItem15 = PickerItem()
    var textItem16 = TextItem()
    var textItem17 = TextItem()
    
    lazy var items: [UIView] = [headerItem, textItem4, textItem5, textItem6, imageItem7, imageItem71, textItem8, textItem9, textItem10, textItem11, pickerItem12, pickerItem13, textItem14, pickerItem15, textItem16, textItem17]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
}

// MARK: - setting ui and constraints
extension MainInfoVC {
    private func setUpUI() {
        view.backgroundColor = .archoBackgroundColor
        view.addSubview(scrollView)
        
        headerItem.configure(title: "Общие данные по объекту")
        
        textItem4.header.configure(number: "4", title: "Наименование объекта")
        textItem4.textView.configure(placeholder: "Укажите название описываемого объекта (обязательно)", text: "Какая-то усадьба")
        
        textItem5.header.configure(number: "5", title: "Состав дворцово-паркового ансамбля")
        
        textItem6.header.configure(number: "6", title: "Адрес объекта")
        textItem6.textView.configure(placeholder: "Укажите адрес объекта")
        
        imageItem7.header.configure(number: "7", title: "Современный вид ОКН")
        imageItem7.imageView.presentingView = self
        imageItem7.delegate = self
        imageItem7.dataSource = self
        
        imageItem71.header.configure(number: "7/1", title: "Первоначальный вид ОКН")
        imageItem71.imageView.presentingView = self
        imageItem71.delegate = self
        imageItem71.dataSource = self
        
        textItem8.header.configure(number: "8", title: "Координаты объекта")
        textItem8.textView.configure(placeholder: "Yet to be coded")
        
        textItem9.header.configure(number: "9", title: "Дата строительства")
        
        textItem10.header.configure(number: "10", title: "Архитектор(ы)")
        
        textItem11.header.configure(number: "11", title: "Сведения о владельцах")
        textItem11.textView.configure(placeholder: "Укажите владельца и годы владения")
        
        pickerItem12.header.configure(number: "12", title: "Типологическая принадлежность")
        pickerItem12.pickerView.dataSource = self
        pickerItem12.pickerView.delegate = self
        
        pickerItem13.header.configure(number: "13", title: "Охранный статус объекта ОКН")
        pickerItem13.pickerView.dataSource = self
        pickerItem13.pickerView.delegate = self
        
        textItem14.header.configure(number: "14", title: "Краткое архитектурное описание:")
        textItem14.textView.configure(placeholder: "Укажите материалы, форму и декор здания, характер фундамента, форму крыши и другие особенности")
        
        pickerItem15.header.configure(number: "15", title: "Характеристика технического состояния объекта")
        pickerItem15.pickerView.dataSource = self
        pickerItem15.pickerView.delegate = self
        
        textItem16.header.configure(number: "16", title: "Характер современного использования")
        textItem16.textView.configure(placeholder: "Укажите современное назначение (использование) объекта")
        
        textItem17.header.configure(number: "17", title: "Необходимые первоочередные работы")
        textItem17.textView.configure(placeholder: "Какие на ваш взгляд, необходимы первоочередные работы для сохранения данного объекта?")
        
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

extension MainInfoVC: ImageItemDelegate, ImageItemDataSource {
    func imageItem(_ imageItemView: ImageItem, didFinishPicking images: [UIImage]) {
        images.forEach { image in
            self.images.append(image)
        }
    }
    
    func imageItem(numberOfItemsIn imageItemView: ImageItem) -> Int? {
        return images.count
    }
    
    func imageItem(_ imageItemView: ImageItem, imageForItemAt index: Int) -> UIImage {
        images[index]
    }
    
    
}

extension MainInfoVC: PickerViewDelegate, PickerViewDataSource {
    func pickerView(_ pickerView: PickerView, didDidSelect value: String) {
        print(value)
    }
    
    func pickerView(optionsFor pickerView: PickerView) -> [String] {
        ["1option", "2option", "3option", "4"]
    }
    
    
}

