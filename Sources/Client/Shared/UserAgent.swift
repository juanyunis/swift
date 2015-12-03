//
//  UserAgent.swift
//  Tinode
//
//  Created by Daniel Thorpe on 03/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation

protocol UserAgentType: Encodable { }

class UserAgent {

    let info: [String: AnyObject]

    var id: String {
        return info["AGENT_ID"] as? String ?? "Tinode Swift SDK"
    }

    var version: String {
        return info["CFBundleShortVersionString"] as! String
    }

    var build: String {
        return info["CFBundleVersion"].map { String($0) } ?? "1"
    }

    init(_ info: [String: AnyObject] = NSBundle(forClass: UserAgent.self).infoDictionary!) {
        self.info = info
    }
}

extension UserAgent: CustomStringConvertible, UserAgentType {

    var description: String {
        // Need to add platform here too
        return "\(id) / \(version) (\(build))"
    }

    func encode() -> Encoded {
        return ["ua": description]
    }
}
