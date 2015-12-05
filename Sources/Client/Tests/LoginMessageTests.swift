//
//  LoginMessageTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class LoginMessageTests: XCTestCase, TypeTestsType {

    var target: LoginMessage!
    let id: MessageId = "1a2b3c"
    let userPasswordPair: Authentication.Basic.UserPasswordPair = ("user", "password")

    override func tearDown() {
        target = nil
        super.tearDown()
    }
}

class LoginMessageEncodableTests: LoginMessageTests {

    func test__with_default_properties_has_no_id() {
        target = LoginMessage(basic: userPasswordPair)
        XCTAssertNil(encodedObjectForKey("id"))
    }

    func test__with_default_properties_has_user_agent() {
        target = LoginMessage(basic: userPasswordPair)
        let value: String? = encodedObjectForKey("ua")
        XCTAssertNotNil(value)
        XCTAssertFalse(value!.isEmpty)
    }

    func test__with_basic_auth() {
        target = LoginMessage(basic: userPasswordPair)
        guard let scheme: String = encodedObjectForKey("scheme"),
              let secret: String = encodedObjectForKey("secret") else {
                XCTFail("scheme & secret not encoded: \(target.encode())")
                return
        }

        XCTAssertEqual(scheme, "basic")
        XCTAssertEqual(secret, "\(userPasswordPair.user):\(userPasswordPair.password)")
    }
}
