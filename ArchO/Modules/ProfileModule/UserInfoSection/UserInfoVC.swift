//
//  UserInfoVC.swift
//  ArchO
//
//  Created by Tixon Markin on 30.08.2023.
//

import Foundation
import UIKit

protocol UserInfoVCInput: AnyObject {
    func endUserInfo()
    func reloadTableView()
}


class UserInfoVC: UIViewController {
    weak var coordinator: ProfileCoordinatorProtocol!
    var interactor: UserInfoInteractorInput!
    
    var tableHeaderLabel: UILabel!
    var infoTable: UITableView!
    var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.requestUserInfoData()
        view.backgroundColor = .archoBackgroundColor
        setUpUI()
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)

    }

    deinit {
        print("deinit UserInfoVC")
    }
    
    private func setUpUI() {
        tableHeaderLabel = UILabel()
        tableHeaderLabel.text = "Заполните данные о себе"
        tableHeaderLabel.frame.size.height = 20
        
        infoTable = UITableView()
        infoTable.delegate = self
        infoTable.dataSource = self
        infoTable.separatorStyle = .none
        infoTable.allowsSelection = false
        infoTable.isScrollEnabled = false
        infoTable.register(UserInfoCell.self, forCellReuseIdentifier: UserInfoCell.cellId)
        
        doneButton = UIButton()
        doneButton.setTitle("ОК", for: .normal)
        doneButton.setTitleColor(.archoBackgroundColor, for: .normal)
        doneButton.backgroundColor = .archoSecondaryColor
        doneButton.layer.cornerRadius = 24
        doneButton.layer.borderWidth = 1
        doneButton.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        
        view.addSubviews(tableHeaderLabel, infoTable, doneButton)
        
    }
    
    private func setUpConstraints() {
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            tableHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableHeaderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoTable.topAnchor.constraint(equalTo: tableHeaderLabel.bottomAnchor, constant: 5),
            infoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            infoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoTable.heightAnchor.constraint(equalToConstant: 324),
            doneButton.topAnchor.constraint(equalTo: infoTable.bottomAnchor, constant: 24),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 48),
            doneButton.widthAnchor.constraint(equalToConstant: 152)
        ])
    }
    
    @objc func didTapDoneButton() {
        interactor.didTapDoneButton()
    }
}

extension UserInfoVC: UserInfoVCInput {
    func reloadTableView() {
        infoTable.reloadData()
    }
    
    func endUserInfo() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserInfoVC: UserInfoCellDelegate {
    func editingChanged(to text: String, inCell cell: UserInfoCell) {
        interactor.editingChanged(toText: text, inCellOfType: cell.contentType)
    }
    
    func indicatorSwitched(to value: Bool, inCell cell: UserInfoCell) {
        interactor.indicatorSwitched(toValue: value, inCellOfType: cell.contentType)
    }
}

extension UserInfoVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.cellId, for: indexPath) as! UserInfoCell
        
        var cellType: UserInfoCellContentType!
        switch indexPath.row {
        case 0:
            cellType = .name
        case 1:
            cellType = .lastName
        case 2:
            cellType = .phoneNumber
        case 3:
            cellType = .email
        case 4:
            cellType = .country
        case 5:
            cellType = .city
        default:
            print("Error in 'UserInfoVC/tableViewCellForRowAt'")
        }
        let data = interactor.getUserInfoFieldData(cellType)
        cell.configure(data: data, type: cellType)
        cell.delegate = self
        
        return cell
    }
}

extension UserInfoVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
}
