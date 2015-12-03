//
//  UserAgentTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class UserAgentTests: XCTestCase, TypeTestsType {
    var target: UserAgent!

    override func tearDown() {
        target = nil
        super.tearDown()
    }
}

class UserAgentPropertyTests: UserAgentTests {

    func test__id() {
        target = UserAgent(["AGENT_ID": "Tinode Test Suite"])
        XCTAssertEqual(target.id, "Tinode Test Suite")
    }

    func test__id_fallback() {
        target = UserAgent([:])
        XCTAssertEqual(target.id, "Tinode Swift SDK")
    }

    func test__version() {
        target = UserAgent(["CFBundleShortVersionString": "3.2.1"])
        XCTAssertEqual(target.version, "3.2.1")
    }

    func test__build() {
        target = UserAgent(["CFBundleVersion": "666"])
        XCTAssertEqual(target.build, "666")
    }

    func test__build_fallback() {
        target = UserAgent([:])
        XCTAssertEqual(target.build, "1")
    }
}

class UserAgentDescriptionTests: UserAgentTests {

    override func setUp() {
        super.setUp()
        target = UserAgent([
            "AGENT_ID": "Tinode Test Suite",
            "CFBundleShortVersionString": "3.2.1",
            "CFBundleVersion": "666"
        ])
    }

    func test__description() {
        XCTAssertEqual(target.description, "Tinode Test Suite / 3.2.1 (666)")
    }
}

class UserAgentEncodableTests: UserAgentDescriptionTests {

    func test__encoded_value() {
        let value: String? = encodedObjectForKey("ua")
        XCTAssertEqual(value, target.description)
    }
}