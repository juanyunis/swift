//
//  MessageId.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct MessageId: Equatable, CustomStringConvertible, StringLiteralConvertible, Encodable {

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

    func encode() -> Encoded {
        return ["id": description]
    }
}

func ==(lhs: MessageId, rhs: MessageId) -> Bool {
    return lhs.description == rhs.description
}
