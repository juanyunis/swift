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

internal extension String {

    static func random(length: Int = 6, from allowedChars: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/") -> String {
        let allowedCharsCount = UInt32(allowedChars.characters.count)
        var result = ""

        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let newCharacter = allowedChars[allowedChars.startIndex.advancedBy(randomNum)]
            result += String(newCharacter)
        }
        
        return result
    }
}