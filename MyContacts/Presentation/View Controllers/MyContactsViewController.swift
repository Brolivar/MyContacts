//
//  ViewController.swift
//  MyContacts
//
//  Created by Jose Bolivar on 16/10/21.
//

import UIKit

class MyContactsViewController: UIViewController {

    // MARK: - Properties
    private let contactsTableView = UITableView()


    // MARK: - Public Variables
    //Ideally this should be injected by a third party entity (i.e navigator/coordinator, segue manager, etc...)
    var contactsManager: ContactsManagerProtocol! = ContactsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.fetchMyContacts()
    }


    // MARK: - Functions

    private func fetchMyContacts() {

        // Because the contact store methods are synchronous, it is recommended to use them on background threads for performance
        DispatchQueue.global(qos: .userInitiated).async {
            self.contactsManager.fetchContacts { status in
                if status {
                    DispatchQueue.main.async {  // This is run on the main queue, after the previous code in outer block
                        print("Updating UI...")
                        self.contactsTableView.reloadData()
                    }
                }
            }
        }
    }

    private func setupUI() {
        self.contactsTableView.delegate = self
        self.contactsTableView.dataSource = self
        self.view.addSubview(self.contactsTableView)
        self.contactsTableView.translatesAutoresizingMaskIntoConstraints = false

//        contactsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        contactsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        contactsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        contactsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource extension
extension MyContactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactsManager.contactsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate extension
extension MyContactsViewController: UITableViewDelegate {}

