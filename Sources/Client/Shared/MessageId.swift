//
//  MessageId.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

protocol MessageIdType: CustomStringConvertible, Encodable { }

extension MessageIdType {

    func encode() -> Encoded {
        return ["id": description]
    }
}

struct MessageId: Equatable, StringLiteralConvertible, MessageIdType {

    let description: String

    init(_ value: String) {
        description = value
    }

    init(unicodeScalarLiteral value: Swift.UnicodeScalarType) {
        description = value
    }

    init(extendedGraphemeClusterLiteral value: Swift.ExtendedGraphemeClusterType) {
        description = value
    }

    init(stringLiteral value: Swift.StringLiteralType) {
        description = value
    }
}

func ==(lhs: MessageId, rhs: MessageId) -> Bool {
    return lhs.description == rhs.description
}

struct IncrementalMessageId: Equatable, IntegerLiteralConvertible, MessageIdType {

    let prefix: String
    private(set) var current: Int

    var description: String {
        return "\(prefix)\(current)"
    }

    init(_ value: Int, prefix: String? = .None) {
        self.current = value
        self.prefix = prefix ?? ""
    }

    init(integerLiteral value: Int) {
        self.init(value)
    }
}

func ==(lhs: IncrementalMessageId, rhs: IncrementalMessageId) -> Bool {
    return lhs.current == rhs.current && lhs.prefix == rhs.prefix
}

postfix func ++(inout x: IncrementalMessageId) -> IncrementalMessageId {
    return IncrementalMessageId(x.current++, prefix: x.prefix)
}

prefix func ++(inout x: IncrementalMessageId) -> IncrementalMessageId {
    return IncrementalMessageId(++x.current, prefix: x.prefix)
}

