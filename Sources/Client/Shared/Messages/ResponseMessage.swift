//
//  ResponseMessage.swift
//  Tinode
//
//  Created by Daniel Thorpe on 05/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation
import Decodable

struct ResponseMessage {

    /// - returns: success/failure code
    let code: Int

    /// - returns: success/failure text description
    let text: String

    /// - returns: the timestamp
    let timestamp: NSDate

    /// - returns: optional topic name if the response was related to a topic
    let topic: String?

    /// - returns: generic response parameters, context dependent
    let parameters: Encoded?
}

extension ResponseMessage {

    func parameterForKey<T>(key: String) -> T? {
        return parameters?[key] as? T
    }
}

extension ResponseMessage: ServerPayloadType {

    static func decode(json: AnyObject) throws -> ResponseMessage {
        let payload = try json => "ctrl"
        return try ResponseMessage(
            code: payload => "code",
            text: payload => "text",
            timestamp: NSDate.fromRFC3339FormattedString(payload => "ts")!,
            topic: try? payload => "topic",
            parameters: try? payload => "params"
        )
    }
}
