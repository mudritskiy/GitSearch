//
//  DateFormatter.swift
//  GitSearch
//
//  Created by Vldmr on 12/24/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static let localeFormat = NSLocalizedString("date-formatter.locale", tableName: nil, bundle: .main, value: "en_US_POSIX", comment: "Date local display format")

    static let MonthDayYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone.current
        formatter.locale = NSLocale.current
        //formatter.dateFormat =  "MMMM d, yyyy"
        formatter.dateStyle = DateFormatter.Style.long
        return formatter
    }()
    
    static let RFC3339DateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: DateFormatter.localeFormat)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()

}
