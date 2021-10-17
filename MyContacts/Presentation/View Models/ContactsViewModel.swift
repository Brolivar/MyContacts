//
//  ContactsViewModel.swift
//  MyContacts
//
//  Created by Jose Bolivar on 16/10/21.
//

import Foundation

protocol ContactsManagerProtocol {

}

class ContactsViewModel {

    // MARK: - Properties
    //This should be private but Swift doesn't allow private vars in protocols - Privacy is accomplished by injecting an abstraction
    // 'ContactsManagerProtocol' rather of a type 'ContactsViewModel'
    var contactList: [Contact] = []

}

// MARK: - ContactsManager Extension
extension ContactsViewModel: ContactsManagerProtocol {

}
