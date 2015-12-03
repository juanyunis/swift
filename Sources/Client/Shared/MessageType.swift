//
//  MessageType.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Decodable

protocol MessageType {

    /// - returns: id, a MessageIdType?
    var id: MessageIdType? { get }
}

protocol ClientMessageType: MessageType, Encodable { }

