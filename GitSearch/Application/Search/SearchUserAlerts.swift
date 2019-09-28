//
//  SearchViewText.swift
//  GitSearch
//
//  Created by Vldmr on 9/28/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

public enum SearchUserAlerts: String, Localizable {
    
    case noKeyword = "no_keyword"
    case noKeywordMessage = "no_keywork_message"

    case noDataFound = "no_data_found"
    case noDataFoundMessage = "no_data_found_message"

    case errorFound = "error_found"
    
    var tableName: String {
        return "SearchView"
    }
    
}
