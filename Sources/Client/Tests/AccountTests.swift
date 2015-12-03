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

    func test__with_default_properties_has_no_id() {
        target = AccountMessage(basic: userPasswordPair)
        XCTAssertNil(encodedObjectForKey("id"))
    }

    func test__with_default_properties_has_no_context() {
        target = AccountMessage(basic: userPasswordPair)
        XCTAssertNil(encodedObjectForKey("user"))
    }

    func test__with_id() {
        target = AccountMessage(id: "1a2b3c", basic: userPasswordPair)
        let value: String? = encodedObjectForKey("id")
        XCTAssertEqual(value, "1a2b3c")
    }

    func test__with_new_context() {
        target = AccountMessage(context: .New, basic: userPasswordPair)
        let value: String? = encodedObjectForKey("user")
        XCTAssertEqual(value, "new")
    }

    func test__with_basic_auth() {
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

    func test__with_default_user_info() {
        target = AccountMessage(basic: userPasswordPair)
        if let value: Encoded = encodedObjectForKey("init") {
            XCTAssertNil(value["public"])
            XCTAssertNil(value["private"])            
            if let defacs = value["defacs"] as? Encoded {
                XCTAssertEqual(defacs["auth"] as? String, AccessMode().authenticated.encodedValue)
                XCTAssertEqual(defacs["anon"] as? String, AccessMode().anonymous.encodedValue)
            }
            else {
                XCTFail("AccountMessage init property did not contain access mode: \(value)")
            }
        } else {
            XCTFail("AccountMessage init property not encoded correctly: \(target.encode())")
        }
    }

    func test__with_public_info() {
        let publicInfo = PublicInfo(foo: "I am foo")
        let userInfo = UserInfo(publicInfo: publicInfo, privateInfo: .None)
        target = AccountMessage(basic: userPasswordPair, userInfo: userInfo)
        if let value: Encoded = encodedObjectForKey("init") {
            if let info = value["public"] as? Encoded {
                XCTAssertEqual(info["foo"] as? String, "I am foo")
            }
            else {
                XCTFail("AccountMessage init property did not contain public info: \(value)")
            }
        } else {
            XCTFail("AccountMessage init property not encoded correctly: \(target.encode())")
        }
    }

    func test__with_private_info() {
        let publicInfo = PublicInfo(foo: "I am foo")
        let privateInfo = PrivateInfo(bar: "I am bar")
        let userInfo = UserInfo(publicInfo: publicInfo, privateInfo: privateInfo)
        target = AccountMessage(basic: userPasswordPair, userInfo: userInfo)
        if let value: Encoded = encodedObjectForKey("init") {
            if let info = value["public"] as? Encoded {
                XCTAssertEqual(info.keys.count, 1)
                XCTAssertEqual(info["foo"] as? String, "I am foo")
            }
            else {
                XCTFail("AccountMessage init property did not contain public info: \(value)")
            }

            if let info = value["private"] as? Encoded {
                XCTAssertEqual(info.keys.count, 1)
                XCTAssertEqual(info["bar"] as? String, "I am bar")
            }
            else {
                XCTFail("AccountMessage init property did not contain private info: \(value)")
            }
        } else {
            XCTFail("AccountMessage init property not encoded correctly: \(target.encode())")
        }
    }
}
