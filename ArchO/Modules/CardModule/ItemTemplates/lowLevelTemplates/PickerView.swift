//
//  PickerView.swift
//  ArchO
//
//  Created by Tixon Markin on 20.10.2023.
//

import UIKit

protocol PickerViewDelegate: AnyObject {
    func pickerView(_ pickerView: PickerView, didSelectItem item: String)
}

class PickerView: UIView, ItemIdentifiable {
    private var annotationLabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .archoSecondaryColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
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
    
    var itemID: ItemID!
    
    weak var delegate: PickerViewDelegate?
    
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
    
    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        self.addGestureRecognizer(tapGesture)
        self.addSubviews(label, dummyView, annotationLabel)
    }
    
    private func setUpConstraints() {
        PickerView.doNotTranslateAutoLayout(for: label, annotationLabel)
        NSLayoutConstraint.activate([
            annotationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            annotationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            
            label.topAnchor.constraint(equalTo: annotationLabel.bottomAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func configure(text: String? = nil, annotation: String? = nil, options: [String]) {
        label.text = text
        annotationLabel.text = annotation
        pickerOptions = options
    }
    
    @objc private func didTapSelf(_ gesture: UITapGestureRecognizer) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneSelecting))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
 
        let toolbar = UIToolbar()
        toolbar.setItems([space, doneButton], animated: false)
        toolbar.sizeToFit()
        
        dummyView.inputView = picker
        dummyView.inputAccessoryView = toolbar
        
        picker.delegate = self
        picker.dataSource = self
        
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
        return pickerOptions.count
    }
    
}
extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard component == 0 else { return nil}
        return pickerOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = pickerOptions[row]
        delegate?.pickerView(self, didSelectItem: pickerOptions[row])
    }
}
