//
//  UserInfoTextField.swift
//  ArchO
//
//  Created by Tixon Markin on 30.08.2023.
//

import Foundation
import UIKit

protocol UserInfoTFDelegate: AnyObject {
    func editingChanged(to text: String)
    func indicatorSwitched(to value: Bool)
}

class UserInfoTextField: UIView {
    var textField: UITextField!
    var isSelected: Bool = false
    var indicatorView: UIView!
    weak var delegate: UserInfoTFDelegate?

    init() {
        super.init(frame: .zero)
        setUpUI()
        addInteraction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    func setInitialValues(text: String?, isSelected: Bool?, placeholder: String) {
        textField.placeholder = placeholder
        textField.text = text
        if isSelected != nil {
            self.isSelected = isSelected!
            indicatorView.backgroundColor = self.isSelected ? .archoTurquoise : .archoBackgroundColor
        }
    }
    
    private func setUpUI() {
        layer.cornerRadius = 5
        layer.borderColor = UIColor.archoSecondaryColor.cgColor
        layer.borderWidth = 1
        
        textField = UITextField()
        textField.autocapitalizationType = .words
        
        indicatorView = UIView()
        indicatorView.backgroundColor = isSelected ? .archoTurquoise : .archoBackgroundColor
        indicatorView.layer.cornerRadius = 5
        indicatorView.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        indicatorView.layer.borderWidth = 1
    
        self.addSubviews(textField, indicatorView)
    }
    
    private func setUpConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            
            indicatorView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            indicatorView.widthAnchor.constraint(equalTo: indicatorView.heightAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 6),
            indicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
    }
}

// MARK: interaction functionality
private extension UserInfoTextField {
    func addInteraction() {
        textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleIndicatorAction))
        indicatorView.addGestureRecognizer(tapGesture)
    }
    
    @objc func editingChanged() {
        guard let text = textField.text else { return }
        delegate?.editingChanged(to: text)
    }
    
    @objc func toggleIndicatorAction()  {
        isSelected = !isSelected
        indicatorView.backgroundColor = isSelected ? .archoTurquoise : .archoBackgroundColor
        delegate?.indicatorSwitched(to: isSelected)
    }
    
}
