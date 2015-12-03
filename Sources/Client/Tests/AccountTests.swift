//
//  AccountTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class AccountMessageTests: XCTestCase, TypeTestsType {

    var target: AccountMessage!
    let userPasswordPair: Authentication.Basic.UserPasswordPair = ("user", "password")

    override func tearDown() {
        target = nil
        super.tearDown()
    }
}

class AccountMessageEncodableTests: AccountMessageTests {

    func test__message_encoded_with_default_properties_has_no_id() {
        target = AccountMessage(basic: userPasswordPair)
        XCTAssertNil(encodedObjectForKey("id"))
    }

    func test__message_encoded_with_default_properties_has_no_context() {
        target = AccountMessage(basic: userPasswordPair)
        XCTAssertNil(encodedObjectForKey("user"))
    }

    func test__message_encoded_with_id() {
        target = AccountMessage(id: "1a2b3c", basic: userPasswordPair)
        let value: String? = encodedObjectForKey("id")
        XCTAssertEqual(value, "1a2b3c")
    }

    func test__message_encoded_with_new_context() {
        target = AccountMessage(context: .New, basic: userPasswordPair)
        let value: String? = encodedObjectForKey("user")
        XCTAssertEqual(value, "new")
    }

    func test__message_encoded_with_basic_auth() {
        target = AccountMessage(basic: userPasswordPair)

        if let values: [Encoded] = encodedObjectForKey("auth") {
            if let basic = values.filter({ $0["scheme"] as? String == "basic" }).first {
                XCTAssertEqual(basic["secret"] as? String, "\(userPasswordPair.user):\(userPasswordPair.password)")
            }
            else {
                XCTFail("AccountMessage auth property did not contain basic scheme: \(values)")
            }
        } else {
            XCTFail("AccountMessage auth property not encoded correctly: \(target.encode())")
        }
    }
}
