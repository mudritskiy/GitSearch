//
//  +String.swift
//  GitSearch
//
//  Created by Vldmr on 9/28/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

extension String {
    
    var localiazed: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(bundle: Bundle = Bundle.main, tableName: String = "Localiazed", comment: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "LocaliazedIt:\(self)", comment: comment)
    }
    
}
