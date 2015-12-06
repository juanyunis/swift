//
//  WebSocketType.swift
//  Tinode
//
//  Created by Daniel Thorpe on 05/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation
import SwiftWebSocket

protocol WebSocketType {

    func open(request: NSURLRequest, subProtocols: [String])

    func send(message: Any)
}

extension WebSocket: WebSocketType { }