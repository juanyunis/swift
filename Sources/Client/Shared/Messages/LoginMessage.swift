//
//  LoginMessage.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct LoginMessage {

    let id: MessageIdType?
    let auth: AuthenticationSchemeType
    let expireIn = "24h"
    let userAgent: UserAgentType?

    init(id: MessageIdType? = .None, auth: AuthenticationSchemeType, userAgent: UserAgentType? = UserAgent()) {
        self.id = id
        self.auth = auth
        self.userAgent = userAgent
    }

    init(id: MessageIdType? = .None, basic: Authentication.Basic.UserPasswordPair, userAgent: UserAgentType? = UserAgent()) {
        self.init(id: id, auth: Authentication.Basic(user: basic.user, password: basic.password), userAgent: userAgent)
    }
}

extension LoginMessage: ClientMessageType {

    func encode() -> Encoded {
        var result = [String: AnyObject]()
        result += id?.encode()
        result += auth.encode()
        result["expireIn"] = expireIn
        result += userAgent?.encode()
        return result
    }
}


