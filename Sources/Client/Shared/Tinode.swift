//
//  Tinode.swift
//  Tinode
//
//  Created by Daniel Thorpe on 02/12/2015.
//  Copyright © 2015 Tinode. All rights reserved.
//

import Foundation

internal func __forTestingPurposes() -> Bool {
    return true
}


internal let __rfc3339DateFormatter: NSDateFormatter = {
    let frmtr = NSDateFormatter()
    frmtr.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    frmtr.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSS'Z'"
    frmtr.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    return frmtr
}()

internal extension NSDate {

    static func fromRFC3339FormattedString(str: String) -> NSDate? {
        return __rfc3339DateFormatter.dateFromString(str)
    }

    var rfc3339FormattedString: String {
        return __rfc3339DateFormatter.stringFromDate(self)
    }
}