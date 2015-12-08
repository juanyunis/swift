//
//  TinodeTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 07/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class StringExtensionTests: XCTestCase {

    func test__random_string_length() {
        XCTAssertEqual(String.random(5).characters.count, 5)
    }

    func test__random_string_content_from() {
        let result = String.random(5, from: "a")
        XCTAssertEqual(result.characters.count, 5)
        XCTAssertEqual(result, "aaaaa")
    }
}
