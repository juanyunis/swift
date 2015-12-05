//
//  ClientMessageTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 05/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class ClientMessageTests: XCTestCase, TypeTestsType {

    var target: ClientMessage!

    override func tearDown() {
        target = nil
        super.tearDown()
    }
}

class EncodableClientMessageTests: ClientMessageTests {

    func test__default_parameters() {
        target = ClientMessage("test") { ["foo": "bar"] }
        XCTAssertNil(encodedObjectForKey("id"))
    }

    func test__message_name() {
        target = ClientMessage("test") { ["foo": "bar"] }
        XCTAssertEqual(encodedMessageName(), "test")
    }

    func test__payload_is_encoded() {
        target = ClientMessage("test") { ["foo": "bar"] }
        let result: String? = encodedObjectForKey("foo")
        XCTAssertEqual(result, "bar")
    }

    func test__with_id() {
        let id: MessageId = "abc123"
        target = ClientMessage("test", id: id) { ["foo": "bar"] }
        let result: String? = encodedObjectForKey("id")
        XCTAssertEqual(result, "abc123")
    }
}

