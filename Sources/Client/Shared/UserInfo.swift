//
//  UserInfoType.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

struct AccessMode {

    enum Permission {
        case Read, ReadWrite, Denied
    }

    let authenticated: Permission
    let anonymous: Permission

    init(authenticated: Permission = .ReadWrite, anonymous: Permission = .Denied) {
        self.authenticated = authenticated
        self.anonymous = anonymous
    }
}

extension AccessMode.Permission {

    var encodedValue: String {
        switch self {
        case .Read:
            return "R"
        case .ReadWrite:
            return "RWS"
        case .Denied:
            return "X"
        }
    }
}

extension AccessMode: Encodable {

    func encode() -> Encoded {
        return [
            "auth": authenticated.encodedValue,
            "anon": anonymous.encodedValue
        ]
    }
}

struct UserInfo: Encodable {

    let accessMode: AccessMode

    let publicInfo: Encodable?

    let privateInfo: Encodable?

    init(publicInfo: Encodable?, privateInfo: Encodable?, mode: AccessMode = AccessMode()) {
        self.accessMode = mode
        self.publicInfo = publicInfo
        self.privateInfo = privateInfo
    }

    func encode() -> Encoded {
        var encoded = [
            "defacs": accessMode.encode()
        ]

        encoded["public"] = publicInfo?.encode()
        encoded["private"] = privateInfo?.encode()

        return encoded
    }

}

