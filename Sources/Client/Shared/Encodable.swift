//
//  Encodable.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

public typealias Encoded = [String: AnyObject]

public protocol Encodable {
    func encode() -> Encoded
}

internal func +=<Key, Value>(inout lhs: Dictionary<Key, Value>, rhs: Dictionary<Key, Value>?) {
    if let rhs = rhs {
        for (key, value) in rhs {
            lhs[key] = value
        }
    }
}

