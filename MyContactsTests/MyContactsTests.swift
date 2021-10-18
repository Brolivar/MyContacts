//
//  MyContactsTests.swift
//  MyContactsTests
//
//  Created by Jose Bolivar on 16/10/21.
//

import XCTest
@testable import MyContacts

class MyContactsTests: XCTestCase {

    private var contactManager: ContactFetcherProtocol = ContactFetcher()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testContactsFetchSuccess() {
        let ex = expectation(description: "Expecting a success return from the manager")

        self.contactManager.requestContacts { result in
            switch result {
            case .success(_):
                ex.fulfill()
            case .failure(let error):
                print("Contact request failed: ", error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 15) { (error) in
            if let error = error {
                XCTFail("Timeout error: \(error)")
            }
        }
    }

    func testContactsFetchisEmpty() {
        let ex = expectation(description: "Expecting a success return from the manager")

        self.contactManager.requestContacts { result in
            switch result {
            case .success(let contactList):
                if contactList.isEmpty {
                    print("Return object is nil")
                } else {
                    ex.fulfill()
                }
            case .failure(let error):
                print("Contact request failed: ", error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 15) { (error) in
            if let error = error {
                XCTFail("Timeout error: \(error)")
            }
        }
    }
}
