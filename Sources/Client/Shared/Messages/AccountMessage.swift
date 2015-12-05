//
//  Account.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct AccountMessage {

    enum Context {
        case New, Current
    }

    let context: Context
    let auth: AnySequence<AuthenticationSchemeType>
    let userInfo: UserInfo

    init(context: Context = .Current, auth: AnySequence<AuthenticationSchemeType>, userInfo: UserInfo) {
        self.context = context
        self.auth = auth
        self.userInfo = userInfo
    }

    init(context: Context = .Current, auth: AuthenticationSchemeType..., userInfo: UserInfo = UserInfo(publicInfo: .None, privateInfo: .None)) {
        self.init(context: context, auth: AnySequence(auth), userInfo: userInfo)
    }

    init(context: Context = .Current, basic: Authentication.Basic.UserPasswordPair, userInfo: UserInfo = UserInfo(publicInfo: .None, privateInfo: .None)) {
        self.init(context: context, auth: Authentication.Basic(user: basic.user, password: basic.password), userInfo: userInfo)
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

extension AccountMessage: ClientPayloadType {

    var name: String {
        return "acc"
    }

    func encode() -> Encoded {
        var result = [String: AnyObject]()
        result += context.encode()
        result["auth"] = auth.map { $0.encode() }
        result["init"] = userInfo.encode()
        return result
    }
}


