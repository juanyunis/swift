//
//  Account.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

enum AuthenticationScheme {
    case Basic(String)
}

extension AuthenticationScheme: Encodable {

    var schemeName: String {
        switch self {
        case .Basic(_):
            return "basic"
        }
    }

    func encode() -> Encoded {
        var encoded = ["scheme": schemeName]
        switch self {
        case .Basic(let secret):
            encoded["secret"] = secret
        }
        return encoded
    }
}

struct AccountMessage: ClientMessageType {

    enum Context {
        case New, Current
    }

    let id: MessageId?
    let context: Context
    let auth: Array<AuthenticationScheme>

    init(id: MessageId? = .None, context: Context = .Current, auth: [AuthenticationScheme]) {
        self.id = id
        self.context = context
        self.auth = auth
    }

    init(id: MessageId? = .None, context: Context = .Current, basic secret: String) {
        self.init(id: id, context: context, auth: [.Basic(secret)])
    }

    func encode() -> Encoded {

        var result = Dictionary<String, AnyObject>()

        if let id = id {
            result += id.encode()
        }

        result += context.encode()

        if !auth.isEmpty {
            result["auth"] = auth.map { $0.encode() }
        }

        // TODO: defacs?

        // TODO: UserInfo

        return result
    }
}

extension AccountMessage.Context: Encodable {

    func encode() -> Encoded {
        switch self {
        case .New:
            return ["user": "new"]
        default:
            return [:]
        }
    }
}
