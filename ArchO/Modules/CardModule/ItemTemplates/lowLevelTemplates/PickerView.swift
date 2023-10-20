//
//  PickerView.swift
//  ArchO
//
//  Created by Tixon Markin on 20.10.2023.
//

import UIKit

protocol PickerViewDataSource: AnyObject {
    func pickerView(optionsFor pickerView: PickerView) -> [String]
}

protocol PickerViewDelegate: AnyObject {
    func pickerView(_ pickerView: PickerView, didDidSelect value: String)
}

class PickerView: UIView {
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .archoSecondaryColor
        label.font = UIFont.systemFont(ofSize: 16)
//        label.layer.cornerRadius = 5
//        label.layer.borderColor = UIColor.archoSecondaryColor.cgColor
//        label.layer.borderWidth = 1.5
        return label
    }()
    private var picker = UIPickerView()
    private var dummyView = UITextField(frame: .zero)
    
    private var pickerOptions: [String] = []
    
    var delegate: PickerViewDelegate?
    var dataSource: PickerViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: TextView.noIntrinsicMetric, height: 42)
    }

    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        label.text = "Не указано"
        
        dummyView.inputView = picker
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneSelecting))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.setItems([space, doneButton], animated: true)
        dummyView.inputAccessoryView = toolbar
        
        picker.delegate = self
        picker.dataSource = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        self.addGestureRecognizer(tapGesture)
        self.addSubviews(label, dummyView)
    }
    
    private func setUpConstraints() {
        PickerView.doNotTranslateAutoLayout(for: label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    func configure(text: String? = nil) {
        label.text = text
    }
    
    @objc private func didTapSelf(_ gesture: UITapGestureRecognizer) {
        dummyView.becomeFirstResponder()
    }
    
    @objc private func doneSelecting() {
        dummyView.endEditing(true)
    }
}

extension PickerView: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerOptions = dataSource?.pickerView(optionsFor: self) ?? []
        return pickerOptions.count
    }
    
}
extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard component == 0 else { return nil}
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedTitle = pickerOptions[row]
        label.text = selectedTitle
        delegate?.pickerView(self, didDidSelect: selectedTitle)
    }
}
