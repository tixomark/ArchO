//
//  DateView.swift
//  ArchO
//
//  Created by Tixon Markin on 18.10.2023.
//

import UIKit

protocol DateViewDelegate: AnyObject {
    func dateView(_ dateView: DateView, dateDidChangeTo date: Date)
}

class DateView: UIView, ItemIdentifiable {
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .archoSecondaryColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.maximumDate = .init(timeIntervalSinceNow: .zero)
        picker.preferredDatePickerStyle = .compact
        picker.datePickerMode = .date
        return picker
    }()
    
    weak var delegate: DateViewDelegate?
    
    var itemID: ItemID!
    
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
        return CGSize(width: TextView.noIntrinsicMetric, height: 46)
    }

    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
        self.addSubviews(label, datePicker)
    }
    
    private func setUpConstraints() {
        UIView.doNotTranslateAutoLayout(for: datePicker, label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),

            datePicker.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            datePicker.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    
    func configure(annotation: String? = nil,
                   date: Date = Date(timeIntervalSinceNow: .zero)) {
        label.text = annotation
        datePicker.setDate(date, animated: true)
    }
    
    @objc private func dateDidChange(_ sender: UIDatePicker) {
        let date = sender.date
        delegate?.dateView(self, dateDidChangeTo: date)
    }
   
}
