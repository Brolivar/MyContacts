//
//  ContactManager.swift
//  MyContacts
//
//  Created by Jose Bolivar on 16/10/21.
//

import Foundation
import Contacts

protocol ContactFetcherProtocol: AnyObject {
    func requestContacts(completion: @escaping (Result<[Contact], RequestError>) -> Void)
}

// Error tracking for the request:
// On a real scenario, more errors would be used/added, for better accuracy tracking (this is just an example)
enum RequestError: Error {
    case requestError
    case enumerateError
    case accessDeniedError
}

// Layer in charge of fetching the Contacts, using the Contacts native framework.
class ContactFetcher {

    // MARK: - Properties
    private let contactStore = CNContactStore()

    // Ask the user to grant or deny access to contact data on a per-app basis
    private func requestContactsAccess(completion: @escaping (Bool) -> Void) {
        // Use the asynchronous method requestAccess(for:completionHandler:) in order to request permissions
        self.contactStore.requestAccess(for: .contacts) { granted, error in
            if let error = error {
                print("Error: Failed to request contacts access: ", error)
                return
            }
            if granted {
                print("Contacts access granted")
                completion(true)
            } else {
                print("Contacts access denied")
                completion(false)
            }
        }
    }
}

// MARK: - ContactFetcherProtocol Extension
extension ContactFetcher: ContactFetcherProtocol {

    func requestContacts(completion: @escaping (Result<[Contact], RequestError>) -> Void) {
        var contactList: [Contact] = [] // Retrieved contact data

        self.requestContactsAccess { access in
            if access {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])

                fetchRequest.sortOrder = .givenName
                fetchRequest.mutableObjects = false

                do {
                    try CNContactStore().enumerateContacts(with: fetchRequest) { (contact, stopPointer ) -> Void in
                        let newContact = Contact(name: contact.givenName, surname: contact.familyName, phoneNumber: contact.phoneNumbers.first?.value.stringValue)
                        contactList.append(newContact)
                    }
                    completion(.success(contactList))
                } catch let error as NSError {
                    print("Failed to enumerate contacts: ", error.localizedDescription)
                    completion(.failure(.enumerateError))
                }

            } else {
                completion(.failure(.accessDeniedError))
            }
        }
    }
}
