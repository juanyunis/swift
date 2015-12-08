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

struct NumericalMessageId: Equatable, IntegerLiteralConvertible, MessageIdType {

    let prefix: String
    let current: Int

    var description: String {
        return "\(prefix)\(current)"
    }

    init(_ value: Int = 0, prefix: String? = .None) {
        self.current = value
        self.prefix = prefix ?? ""
    }

    init(integerLiteral value: Int) {
        self.init(value)
    }
}

extension NumericalMessageId: GeneratorType {

    func next() -> NumericalMessageId? {
        return NumericalMessageId(current + 1, prefix: prefix)
    }
}

func ==(lhs: NumericalMessageId, rhs: NumericalMessageId) -> Bool {
    return lhs.current == rhs.current && lhs.prefix == rhs.prefix
}
