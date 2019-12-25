//
//  CustomDateJSON.swift
//  GitSearch
//
//  Created by Vldmr on 12/25/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

protocol HasDateFormatter {
    static var dateFormatter: DateFormatter { get }
}

struct CustomDateJSON<E: HasDateFormatter>: Codable {
    
    let value: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let text = try container.decode(String.self)
        guard let date = E.dateFormatter.date(from: text) else {
            throw CustomDateError.general
        }
        self.value = date
    }
 
    // TODO: handle errors
    enum CustomDateError: Error {
        case general
    }

}

struct RFC5322Date: HasDateFormatter {
    static var dateFormatter: DateFormatter {
        return DateFormatter.RFC3339DateFormatter
    }
}
