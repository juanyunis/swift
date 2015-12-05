//
//  LoginMessage.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct LoginMessage {

    let name: String
    let auth: AuthenticationSchemeType
    let userAgent: UserAgentType?

    init(name: String = "login", auth: AuthenticationSchemeType, userAgent: UserAgentType? = UserAgent()) {
        self.name = name
        self.auth = auth
        self.userAgent = userAgent
    }

    init(basic: Authentication.Basic.UserPasswordPair, userAgent: UserAgentType? = UserAgent()) {
        self.init(auth: Authentication.Basic(user: basic.user, password: basic.password), userAgent: userAgent)
    }
}

extension LoginMessage: MessageType {

    func encode() -> Encoded {
        var result = [String: AnyObject]()
        result += auth.encode()
        result += userAgent?.encode()
        return result
    }
}


