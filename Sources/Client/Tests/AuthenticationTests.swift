//
//  AuthenticationTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class BasicAuthenticationSchemeTests: XCTestCase, TypeTestsType {

    let user = "my user"
    let password = "super secret"
    var target: Authentication.Basic!

    override func setUp() {
        super.setUp()
        target = Authentication.Basic(user: user, password: password)
    }

    func test__scheme_name() {
        XCTAssertEqual(target.schemeName, "basic")
    }

    func test__encodes_scheme() {
        let value: String? = encodedObjectForKey("scheme")
        XCTAssertEqual(value, "basic")
    }

    func test__encodes_secret() {
        let value: String? = encodedObjectForKey("secret")
        XCTAssertEqual(value, "\(user):\(password)")
    }
}
