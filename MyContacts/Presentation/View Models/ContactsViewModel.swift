//
//  ContactsViewModel.swift
//  MyContacts
//
//  Created by Jose Bolivar on 16/10/21.
//

import Foundation

protocol ContactsManagerProtocol {
    func fetchContacts(completion: @escaping (Bool) -> Void)
    func contactsCount() -> Int
    func contactAt(_ index: Int) -> ContactProtocol?
}

class ContactsViewModel {

    // MARK: - Properties
    //This should be private but Swift doesn't allow private vars in protocols - Privacy is accomplished by injecting an abstraction
    // 'ContactsManagerProtocol' rather of a type 'ContactsViewModel'
    var contactList: [Contact] = []
    private var contactFetcher: ContactFetcherProtocol = ContactFetcher()
}

// MARK: - ContactsManager Extension
extension ContactsViewModel: ContactsManagerProtocol {

    func contactsCount() -> Int {
        return self.contactList.count
    }

    func contactAt(_ index: Int) -> ContactProtocol? {
        if index >= 0 && index < self.contactList.count {       // Out of index protection
            return self.contactList[index]
        } else {
            return .none
        }
    }

    func fetchContacts(completion: @escaping (Bool) -> Void) {

        self.contactFetcher.requestContacts { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let fetchedContacts):
                print("Fetch finished: ", fetchedContacts.count)
                self.contactList = fetchedContacts
                completion(true)
            case .failure(let error):
                print("Request failed: ", error)
                completion(false)
            }

        }
    }

}
