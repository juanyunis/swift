//
//  ResponseMessageTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 05/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class ResponseMessageTests: XCTestCase {

    var json: NSDictionary!

    override func tearDown() {
        json = nil
        super.tearDown()
    }
}

class DecodableResponseMessageTests: ResponseMessageTests {

    func test__non_optional_properties_are_decoded() {
        json = [
            "ctrl": [
                "code": 200,
                "text": "OK",
                "ts": "2015-10-06T18:07:29.841Z"
            ]
        ]
        let response = try! ResponseMessage.decode(json)
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.text, "OK")
    }

    func test__optional_properties_are_decoded() {
        json = [
            "ctrl": [
                "code": 200,
                "text": "OK",
                "ts": "2015-10-06T18:07:29.841Z",
                "topic": "testing topic",
                "params": [
                    "foo": "bar"
                ]
            ]
        ]
        let response = try! ResponseMessage.decode(json)
        XCTAssertEqual(response.code, 200)
        XCTAssertEqual(response.text, "OK")
        XCTAssertEqual(response.topic, "testing topic")
        XCTAssertEqual(response.parameterForKey("foo"), "bar")
    }

}
