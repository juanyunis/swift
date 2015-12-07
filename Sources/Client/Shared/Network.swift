//
//  Network.swift
//  Tinode
//
//  Created by Daniel Thorpe on 07/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation
import SwiftWebSocket

class _Network<WebSocket: WebSocketType> {

    let api: String
    let websocket: WebSocket

    init(api: String) {
        self.api = api
        self.websocket = WebSocket()
    }
}

typealias Network = _Network<WebSocket>





