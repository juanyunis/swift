//
//  Account.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct AccountMessage: ClientMessageType {

    enum Context {
        case New, Current
    }

    let id: MessageId?
    let context: Context
    let auth: AnySequence<AuthenticationSchemeType>

    init(id: MessageId? = .None, context: Context = .Current, auth: AnySequence<AuthenticationSchemeType>) {
        self.id = id
        self.context = context
        self.auth = auth
    }

    init(id: MessageId? = .None, context: Context = .Current, auth: AuthenticationSchemeType...) {
        self.init(id: id, context: context, auth: AnySequence(auth))
    }

    init(id: MessageId? = .None, context: Context = .Current, basic: Authentication.Basic.UserPasswordPair) {
        self.init(id: id, context: context, auth: Authentication.Basic(user: basic.user, password: basic.password))
    }

    func encode() -> Encoded {

        var result = Dictionary<String, AnyObject>()

        if let id = id {
            result += id.encode()
        }

        result += context.encode()

        result["auth"] = auth.map { $0.encode() }


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
