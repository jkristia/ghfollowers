//
//  Stringext.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/26/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
    
    func convertoDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
