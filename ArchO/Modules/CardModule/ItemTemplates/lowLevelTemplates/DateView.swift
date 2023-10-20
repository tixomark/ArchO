//
//  DateView.swift
//  ArchO
//
//  Created by Tixon Markin on 18.10.2023.
//

import UIKit


class DateView: UIView {
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .archoSecondaryColor
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.maximumDate = .init(timeIntervalSinceNow: .zero)
        picker.preferredDatePickerStyle = .compact
        return picker
    }()
    
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
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if self.point(inside: point, with: event) {
//            let pointWithinPicker = CGPoint(x: button.frame.origin.x + 10, y: button.frame.origin.y + 10)
//            let newPoint = convert(pointWithinPicker, to: button.coordinateSpace)
//            let hitTestView = button.hitTest(newPoint, with: event)
//            return hitTestView
//
//        }
//        return nil
//    }

    private func setUpUI() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.archoSecondaryColor.cgColor
        self.layer.borderWidth = 1.5
        
        label.text = "выдерете дату"
        
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
        print(sender.date)
    }
   
}
