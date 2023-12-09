//
//  UserInfoCell.swift
//  ArchO
//
//  Created by Tixon Markin on 31.08.2023.
//

import Foundation
import UIKit

enum UserInfoCellContentType: String {
    case name = "Имя"
    case lastName = "Фамилия"
    case phoneNumber = "Номер телефона"
    case email = "E-mail"
    case country = "Страна"
    case city = "Город"
}

protocol UserInfoCellDelegate: AnyObject {
    func editingChanged(to text: String, inCell cell: UserInfoCell)
    func indicatorSwitched(to value: Bool, inCell cell: UserInfoCell)
}

class UserInfoCell: UITableViewCell {
    var contentType: UserInfoCellContentType!
    
    private var mainView: UserInfoTextField!
    weak var delegate: UserInfoCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainView = UserInfoTextField()
        setUpUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setUpConstraints()
    }
    
    private func setUpUI() {
        selectionStyle = .none
        mainView.delegate = self
        contentView.addSubview(mainView)
    }
    
    private func setUpConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 9),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -9),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 9),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -9)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: DBUserContactField?, type: UserInfoCellContentType) {
        contentType = type
        mainView.setInitialValues(text: data?.value, isSelected: data?.isSelected, placeholder: contentType.rawValue)
    }
}

extension UserInfoCell: UserInfoTFDelegate {
    func editingChanged(to text: String) {
        delegate?.editingChanged(to: text, inCell: self)
    }
    
    func indicatorSwitched(to value: Bool) {
        delegate?.indicatorSwitched(to: value, inCell: self)
    }
}
