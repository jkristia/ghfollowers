//
//  Date+ext.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/26/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
}
