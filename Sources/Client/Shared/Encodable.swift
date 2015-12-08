//
//  Encodable.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation

typealias Encoded = [String: AnyObject]
typealias EncodeBlock = () -> Encoded

protocol Encodable {
    func encode() -> Encoded
}

internal extension Encodable {

    func asJSONData() throws -> NSData {
        return try NSJSONSerialization.dataWithJSONObject(encode(), options: [])
    }

    func decoded() throws -> Encoded? {
        return try NSJSONSerialization.JSONObjectWithData(asJSONData(), options: []) as? Encoded
    }
}

internal func +=<Key, Value>(inout lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>?) {
    if let rhs = rhs {
        for (key, value) in rhs {
            lhs[key] = value
        }
    }
}

