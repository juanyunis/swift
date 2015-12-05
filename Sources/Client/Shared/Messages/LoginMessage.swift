//
//  LoginMessage.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct LoginMessage {

    let auth: AuthenticationSchemeType
    let userAgent: UserAgentType?

    init(auth: AuthenticationSchemeType, userAgent: UserAgentType? = UserAgent()) {
        self.auth = auth
        self.userAgent = userAgent
    }

    init(basic: Authentication.Basic.UserPasswordPair, userAgent: UserAgentType? = UserAgent()) {
        self.init(auth: Authentication.Basic(user: basic.user, password: basic.password), userAgent: userAgent)
    }
}

extension LoginMessage: ClientPayloadType {

    var name: String {
        return "login"
    }

    func encode() -> Encoded {
        var result = [String: AnyObject]()
        result += auth.encode()
        result += userAgent?.encode()
        return result
    }
}


