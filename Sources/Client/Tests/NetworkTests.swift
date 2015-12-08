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

struct TestableNetworkConfiguration: NetworkConfigurationType {
    static let createRandomString = { return "testing_not_random" }
}

final class TestableWebSocket: WebSocketType {

    var didOpenWithRequest: NSURLRequest? = .None
    var didOpenWithSubProtocols: [String]? = .None

    var didSendMessage: Any? = .None

    init() { }

    func open(request: NSURLRequest, subProtocols: [String] = []) {
        didOpenWithRequest = request
        didOpenWithSubProtocols = subProtocols
    }

    func send(message: Any) {
        didSendMessage = message
    }
}

typealias TestableNetwork = _Network<TestableWebSocket, TestableNetworkConfiguration>

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

    func didSendData() -> NSData? {
        return network.websocket.didSendMessage as? NSData
    }

    func decodedSentData() throws -> Encoded? {
        return try didSendData().map { try NSJSONSerialization.JSONObjectWithData($0, options: []) as? Encoded } ?? .None
    }
}

class NetworkInitializationTests: NetworkTests {

    func test__default_host_is_set() {
        XCTAssertEqual(network.host, "api.tinode.co")
    }

    func test__api_is_set() {
        XCTAssertEqual(network.api, api)
    }

    func test__id_is_set() {
        let id = network.id.next()
        XCTAssertNotNil(id)
        XCTAssertEqual(id!.description, "testing_not_random1")
    }
}

class NetworkConnectionTests: NetworkTests {

    func test__created_url_request() {
        do {
            let request = try network.createURLRequest()
            XCTAssertEqual(request.URL?.absoluteString, "wss://api.tinode.co/v0/channels")
            XCTAssertEqual(request.allHTTPHeaderFields?["X-Tinode-APIKey"], network.api)
        }
        catch { XCTFail("Unexpected error: \(error)") }
    }

    func test__connection() {
        network.connect()
        guard let didOpenRequest = network.websocket.didOpenWithRequest else {
            XCTFail("WebSocket did not receive open request.")
            return
        }
        XCTAssertEqual(didOpenRequest.URL?.absoluteString, "wss://api.tinode.co/v0/channels")
        XCTAssertEqual(didOpenRequest.allHTTPHeaderFields?["X-Tinode-APIKey"], network.api)
    }
}

class NetworkSendTests: NetworkTests {

    func test__write_payload_returns_client_message() {
        let payload = AccountMessage(basic: ("user", "password"))
        let message = network.write(payload)
        XCTAssertEqual(message.id?.description, "testing_not_random1")
    }

    func test__write_payload_to_socket() {
        let payload = AccountMessage(basic: ("user", "password"))
        let message = network.write(payload)
        do {
            try network.send(message)
            guard let sent = try decodedSentData() else {
                XCTFail("Data not sent to websocket")
                return
            }
            XCTAssertEqual(sent.keys.first, "acc")
        }
        catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}


