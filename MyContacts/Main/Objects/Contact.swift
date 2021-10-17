//
//  Contact.swift
//  MyContacts
//
//  Created by Jose Bolivar on 16/10/21.
//

import Foundation

// By abstracting the Contact into a protocol we ensure the whole object is not shared,
// only the protocol with the functions to read or write, which is way safer.

protocol ContactProtocol {
    func getName() -> String?
    func getSurname() -> String?
    func getPhoneNumber() -> String?
}

// Note: Alternatively we could import the Contacts API and leave this be a CNContact that holds all the information
// I prefered this way for isolation purposes and bring it closer to a real scenario where we would be using our own object (with just the properties we need)
struct Contact {
    private var name: String?
    private var surname: String?
    private var phoneNumber: String?

    init(name: String?, surname: String?, phoneNumber: String?) {
        self.name = name
        self.surname = surname
        self.phoneNumber = phoneNumber 
    }
}

// MARK: - Contact Protocol Extension
extension Contact: ContactProtocol {

    func getName() -> String? {
        return self.name
    }

    func getSurname() -> String? {
        return self.surname
    }

    func getPhoneNumber() -> String? {
        return self.phoneNumber
    }
}
