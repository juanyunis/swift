//
//  MessageType.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Decodable

protocol MessageType {

    /// - returns: id, a MessageId?
    var id: MessageId? { get }
}

protocol ClientMessageType: MessageType, Encodable { }


protocol UserInfoType {
    typealias PublicInfo: Decodable, Encodable

    var publicInfo: PublicInfo? { get set }

    var privateInfo: PublicInfo? { get set }
}




