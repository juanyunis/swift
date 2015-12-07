//
//  Network.swift
//  Tinode
//
//  Created by Daniel Thorpe on 07/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation
import SwiftWebSocket
import SwiftTask

typealias NetworkTask = Task<Void, Void, ErrorType>

protocol NetworkConfigurationType {
    static var createRandomString: () -> String { get }
}

struct NetworkConfiguration: NetworkConfigurationType {
    static let createRandomString = { return String.random() }
}

class _Network<WebSocket: WebSocketType, Configuration: NetworkConfigurationType> {

    let host: String
    let api: String
    let id: AnyGenerator<MessageIdType>
    let websocket: WebSocket

    init(host: String = "api.tinode.co", api: String) {
        self.host = host
        self.api = api

        let _id = NumericalMessageId(prefix: Configuration.createRandomString())
        self.id = anyGenerator {
            return _id.next()
        }

        self.websocket = WebSocket()
    }
}

typealias Network = _Network<WebSocket, NetworkConfiguration>

extension _Network {

    func send(message: ClientMessageType) throws {
        // TODO: SwiftWebSocket's public API is `Any` but... that can't be
        // correct.
        try websocket.send(message.asJSONData())
    }

    func write(payload: ClientPayloadType) -> ClientMessageType {
        return ClientMessage(id: id.next(), payload: payload)
    }

    // TODO: Add Promises/Futures here. The tricky thing is that at
    // the moment we don't have knowledge what the type of the 
    // response should be. E.g. from the spec {acc} -> {ctrl} but
    // the protocols don't express this. To do so would require adding
    // typealiases to ClientPayloadType which complicates things a lot.



}



