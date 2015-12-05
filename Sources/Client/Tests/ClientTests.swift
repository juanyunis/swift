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

protocol TypeTestsType {
    typealias TypeUnderTest

    var target: TypeUnderTest! { get set }
}

extension TypeTestsType where TypeUnderTest: Encodable {

    func encodedObjectForKey(key: String) -> AnyObject? {
        return target.encode()[key]
    }

    func encodedObjectForKey<T>(key: String) -> T? {
        return encodedObjectForKey(key) as? T
    }
}

extension TypeTestsType where TypeUnderTest: ClientMessageType {

    func encodedMessageName() -> String? {
        return target.encode().keys.first
    }

    func encodedPayload() -> Encoded? {
        let encoded = target.encode()
        return encoded[target.payload.name] as? Encoded
    }

    func encodedObjectForKey(key: String) -> AnyObject? {
        return encodedPayload()?[key]
    }

    func encodedObjectForKey<T>(key: String) -> T? {
        return encodedObjectForKey(key) as? T
    }
}

struct PublicInfo: Encodable {
    let foo: String

    func encode() -> Encoded {
        return ["foo": foo]
    }
}

struct PrivateInfo: Encodable {
    let bar: String

    func encode() -> Encoded {
        return ["bar": bar]
    }
}

