//
//  ViewController.swift
//  MyContacts
//
//  Created by Jose Bolivar on 16/10/21.
//

import UIKit
import SnapKit

class MyContactsViewController: UIViewController {

    // MARK: - Properties
    private let contactsTableView = UITableView()
    private var barView = UIView()
    private var contentView = UIView()
    private let cellId = "cell"

    // MARK: - Public Variables
    //Ideally this should be injected by a third party entity (i.e navigator/coordinator, segue manager, etc...)
    var contactsManager: ContactsManagerProtocol! = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.fetchMyContacts()
    }


    // MARK: - Functions

    private func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.contentView)
        self.contentView.addSubview(self.barView)
        self.contentView.addSubview(self.contactsTableView)

        self.setupBarView()
        self.setupTableView()
        self.layoutUI()
    }

    func setupBarView() {
        self.barView.backgroundColor = .white
        let titleLabel = UILabel()
        self.barView.addSubview(titleLabel)
        titleLabel.text = "My Contacts"
        titleLabel.textColor = .black
        titleLabel.sizeToFit()
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(barView)
        }
    }

    private func setupTableView() {
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.contactsTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.cellId)
    }

    private func layoutUI() {
        self.contentView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview()
        }
        self.barView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        self.contactsTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.barView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func fetchMyContacts() {
        // Because the Contact Store methods are synchronous, it is recommended to use them on background threads for performance
        DispatchQueue.global(qos: .userInitiated).async {
            self.contactsManager.fetchContacts { status in
                if status {
                    DispatchQueue.main.async {  // This is run on the main queue, after the previous code in outer block
                        self.contactsTableView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource extension
extension MyContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsManager.contactsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: self.cellId)      // We could use a custom UITableViewCell, but due to simplicity of the project we don't really need one

        if let contact = self.contactsManager.contactAt(indexPath.row) {
            // Format accordingly, since iOS contacts can use name and surname, or either individually
            if let contactName = contact.getName() {
                cell.textLabel?.text = contactName + " " + (contact.getSurname() ?? "")
            } else {
                cell.textLabel?.text = contact.getSurname()
            }
            cell.detailTextLabel?.text = contact.getPhoneNumber() ?? "No number"
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            return cell
        } else {
            print("Error configuring the cell")
            return UITableViewCell()
        }

    }
}

// MARK: - UITableViewDelegate extension
extension MyContactsViewController: UITableViewDelegate {}

