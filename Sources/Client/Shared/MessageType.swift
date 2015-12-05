//
//  MessageType.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Decodable

protocol MessageType: Encodable {

    /// - returns: the name of the message, i.e. `pub`.
    var name: String { get }
}

protocol ClientMessageType: Encodable {

    /// - returns: id, a MessageIdType?
    var id: MessageIdType? { get }

    /// - returns: the payload which is Encodable
    var message: MessageType { get }
}

extension ClientMessageType {

    func encode() -> Encoded {
        var _payload = message.encode()
        _payload += id?.encode()
        return [message.name: _payload]
    }
}

struct BlockMessage: MessageType {

    let name: String
    let block: EncodeBlock

    init(name: String, block: EncodeBlock) {
        self.name = name
        self.block = block
    }

    func encode() -> Encoded {
        return block()
    }
}

struct ClientMessage: ClientMessageType {

    let id: MessageIdType?
    let message: MessageType

    /**
     Creates a client message with a known message type.
     
     - parameter id: an optional message id to send, defaults to .None
     - parameter message: the MessageType value.
    */
    init(id: MessageIdType? = .None, message: MessageType) {
        self.id = id
        self.message = message
    }

    /**
     Creates a "free form" client message which is useful for testing and
     on the fly message sending. For example

     ```swift
     let msg = ClientMessage("test") { ["foo": "bar"] }
     ```

     - parameter name: the name of the message.
     - parameter id: an optional message id to send, defaults to .None
     - parameter block: a EnclodeBlock which return returns an Encoded value.
     */
    init(_ name: String, id: MessageIdType? = .None, block: EncodeBlock) {
        self.init(id: id, message: BlockMessage(name: name, block: block))
    }
}

