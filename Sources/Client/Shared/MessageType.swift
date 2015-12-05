//
//  MessageType.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Decodable

protocol ClientPayloadType: Encodable {

    /// - returns: the name of the message, i.e. `pub`.
    var name: String { get }
}

protocol ClientMessageType: Encodable {

    /// - returns: id, a MessageIdType?
    var id: MessageIdType? { get }

    /// - returns: the payload which is Encodable
    var payload: ClientPayloadType { get }
}

extension ClientMessageType {

    func encode() -> Encoded {
        var _payload = payload.encode()
        _payload += id?.encode()
        return [payload.name: _payload]
    }
}

struct BlockPayload: ClientPayloadType {

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
    let payload: ClientPayloadType

    /**
     Creates a client message with a known message type.
     
     - parameter id: an optional message id to send, defaults to .None
     - parameter message: the MessageType value.
    */
    init(id: MessageIdType? = .None, payload: ClientPayloadType) {
        self.id = id
        self.payload = payload
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
        self.init(id: id, payload: BlockPayload(name: name, block: block))
    }
}


protocol ServerPayloadType: Decodable { }



