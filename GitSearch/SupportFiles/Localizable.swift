//
//  Localizable.swift
//  GitSearch
//
//  Created by Vldmr on 9/28/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

protocol Localizable {

    var tableName: String { get }
    var localized: String { get }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {
    
    var localized: String {
        return rawValue.localized(tableName: tableName)
    }
    
}
