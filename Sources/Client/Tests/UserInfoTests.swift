//
//  UserInfoTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class AccessModeTests: XCTestCase, TypeTestsType {
    var target: AccessMode!

    override func tearDown() {
        target = nil
        super.tearDown()
    }
}

class AccessModeDefaultTests: AccessModeTests {

    override func setUp() {
        super.setUp()
        target = AccessMode()
    }

    func test__default_access_mode__denies_authenticated_access() {
        XCTAssertEqual(target.authenticated, AccessMode.Permission.ReadWrite)
    }

    func test__default_access_mode__denies_anonymous_access() {
        XCTAssertEqual(target.anonymous, AccessMode.Permission.Denied)
    }
}

class AccessModeEncodableTests: AccessModeTests {

    func test__default_init_parameters() {
        target = AccessMode()
        let auth: String? = encodedObjectForKey("auth")
        XCTAssertEqual(auth, "RWS")
        let anon: String? = encodedObjectForKey("anon")
        XCTAssertEqual(anon, "X")
    }

    func test__authenticated_read_authentication() {
        target = AccessMode(authenticated: .Read)
        let value: String? = encodedObjectForKey("auth")
        XCTAssertEqual(value, "R")
    }

    func test__authenticated_readwrite_authentication() {
        target = AccessMode(authenticated: .ReadWrite)
        let value: String? = encodedObjectForKey("auth")
        XCTAssertEqual(value, "RWS")
    }

    func test__authenticated_denied_authentication() {
        target = AccessMode(authenticated: .Denied)
        let value: String? = encodedObjectForKey("auth")
        XCTAssertEqual(value, "X")
    }

    func test__anonymous_read_authentication() {
        target = AccessMode(anonymous: .Read)
        let value: String? = encodedObjectForKey("anon")
        XCTAssertEqual(value, "R")
    }

    func test__anonymous_readwrite_authentication() {
        target = AccessMode(anonymous: .ReadWrite)
        let value: String? = encodedObjectForKey("anon")
        XCTAssertEqual(value, "RWS")
    }

    func test__anonymous_denied_authentication() {
        target = AccessMode(anonymous: .Denied)
        let value: String? = encodedObjectForKey("anon")
        XCTAssertEqual(value, "X")
    }
}

class UserInfoTests: XCTestCase, TypeTestsType {
    var target: UserInfo!
    var publicInfo: PublicInfo!
    var privateInfo: PrivateInfo!

    override func setUp() {
        super.setUp()
        publicInfo = PublicInfo(foo: "I am foo")
        privateInfo = PrivateInfo(bar: "I am bar")
    }

    override func tearDown() {
        target = nil
        publicInfo = nil
        privateInfo = nil
        super.tearDown()
    }
}

class UserInfoEncodableTests: UserInfoTests {

    func test__public_not_encoded_if_nil() {
        target = UserInfo(publicInfo: .None, privateInfo: .None)
        XCTAssertNil(encodedObjectForKey("public"))
    }

    func test__private_not_encoded_if_nil() {
        target = UserInfo(publicInfo: .None, privateInfo: .None)
        XCTAssertNil(encodedObjectForKey("private"))
    }

    func test__access_mode() {
        target = UserInfo(publicInfo: .None, privateInfo: .None)
        let value: Encoded? = encodedObjectForKey("defacs")
        XCTAssertEqual(value?.keys.count ?? 0, 2)
        XCTAssertEqual(value?["auth"] as? String, "RWS")
        XCTAssertEqual(value?["anon"] as? String, "X")
    }

    func test__encoded_public_info() {
        target = UserInfo(publicInfo: publicInfo, privateInfo: .None)
        let value: Encoded? = encodedObjectForKey("public")
        XCTAssertEqual(value?.keys.count ?? 0, 1)
        XCTAssertEqual(value?["foo"] as? String, "I am foo")
    }

    func test__encoded_private_info() {
        target = UserInfo(publicInfo: .None, privateInfo: privateInfo)
        let value: Encoded? = encodedObjectForKey("private")
        XCTAssertEqual(value?.keys.count ?? 0, 1)
        XCTAssertEqual(value?["bar"] as? String, "I am bar")
    }

}



