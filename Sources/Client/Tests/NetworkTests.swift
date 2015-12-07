//
//  NetworkTests.swift
//  Tinode
//
//  Created by Daniel Thorpe on 07/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import XCTest
import SwiftWebSocket
@testable import Tinode

final class TestableWebSocket: WebSocketType {

    var didOpenWithRequest: NSURLRequest? = .None
    var didOpenWithSubProtocols: [String]? = .None

    var didSendMessage: Any? = .None

    init() {

    }

    func open(request: NSURLRequest, subProtocols: [String] = []) {
        didOpenWithRequest = request
        didOpenWithSubProtocols = subProtocols
    }

    func send(message: Any) {
        didSendMessage = message
    }
}

typealias TestableNetwork = _Network<TestableWebSocket>

class NetworkTests: XCTestCase {

    var api: String!
    var network: TestableNetwork!

    override func setUp() {
        api = "abcdefg1234567"
        network = TestableNetwork(api: api)
    }

    override func tearDown() {
        api = nil
        network = nil
        super.tearDown()
    }
}

class NetworkInitializationTests: NetworkTests {

    func test__api_is_set() {
        XCTAssertEqual(network.api, api)
    }
}
