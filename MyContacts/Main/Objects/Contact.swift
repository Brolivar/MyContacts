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

struct Contact {
    private var name: String?
    private var surname: String?
    private var phoneNumber: String?
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
