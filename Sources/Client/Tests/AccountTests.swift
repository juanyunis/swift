//
//  AccountTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class AccountMessageTests: XCTestCase {

    var msg: AccountMessage!

    override func tearDown() {
        msg = nil
        super.tearDown()
    }

    func encodedObjectForKey(key: String) -> AnyObject? {
        return msg.encode()[key]
    }
}

class AccountMessageEncodableTests: AccountMessageTests {

    func test__message_encoded_with_default_properties_has_no_id() {
        msg = AccountMessage(basic: "user:password")
        XCTAssertNil(encodedObjectForKey("id"))
    }

    func test__message_encoded_with_default_properties_has_no_context() {
        msg = AccountMessage(basic: "user:password")
        XCTAssertNil(encodedObjectForKey("user"))
    }

    func test__message_encoded_with_id() {
        msg = AccountMessage(id: "1a2b3c", basic: "user:password")
        let value = encodedObjectForKey("id")
        XCTAssertNotNil(value)
        XCTAssertEqual(value as? String, "1a2b3c")
    }

    func test__message_encoded_with_new_context() {
        msg = AccountMessage(context: .New, basic: "user:password")
        let value = encodedObjectForKey("user")
        XCTAssertNotNil(value)
        XCTAssertEqual(value as? String, "new")
    }

    func test__message_encoded_with_basic_auth() {
        msg = AccountMessage(basic: "user:password")

        if let values = encodedObjectForKey("auth") as? [Encoded] {
            if let basic = values.filter({ $0["scheme"] as? String == "basic" }).first {
                XCTAssertEqual(basic["secret"] as? String, "user:password")
            }
            else {
                XCTFail("AccountMessage auth property did not contain basic scheme: \(values)")
            }
        } else {
            XCTFail("AccountMessage auth property not encoded correctly: \(msg.encode())")
        }
    }
}
