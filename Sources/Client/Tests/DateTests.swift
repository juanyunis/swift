//
//  DateTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 05/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
@testable import Tinode

class DateTests: XCTestCase {

    let string = "2015-10-06T18:07:29.841Z"

    func test__rfc3339_date_from_string() {
        let date: NSDate? = NSDate.fromRFC3339FormattedString(string)
        XCTAssertNotNil(date)
        XCTAssertEqual(date!.rfc3339FormattedString, string)
    }
}
