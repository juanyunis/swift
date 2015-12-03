//
//  Authenticaton.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

protocol AuthenticationSchemeType: Encodable {

    var schemeName: String { get }
}

struct Authentication {

    struct Basic: AuthenticationSchemeType {

        typealias UserPasswordPair = (user: String, password: String)

        let schemeName = "basic"
        let user: String
        let password: String

        var secretEncodedValue: String {
            return "\(user):\(password)"
        }

        init(user: String, password: String) {
            self.user = user
            self.password = password
        }

        func encode() -> Encoded {
            return [
                "scheme": schemeName,
                "secret": secretEncodedValue
            ]
        }
    }
}
