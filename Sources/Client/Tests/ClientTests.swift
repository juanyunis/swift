//
//  ClientTests.swift
//  ClientTests
//
//  Created by Daniel Thorpe on 02/12/2015.
//
//

import XCTest
@testable import Tinode

class ClientTests: XCTestCase {

    func test__run_test_suite() {
        XCTAssertTrue(__forTestingPurposes())
    }
}
