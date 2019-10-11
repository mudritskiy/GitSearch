//
//  SearchViewText.swift
//  GitSearch
//
//  Created by Vldmr on 9/28/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

public enum SearchUserAlerts: String {
    case noKeyword
    case noDataFound
    case errorFound
}

extension SearchUserAlerts {
    
    public var title: String {
        switch self {
        case .noKeyword:
            return NSLocalizedString("alert.no-keyword", value: "No keyword", comment: "No keyword was entered (title)")
        case .noDataFound:
            return NSLocalizedString("alert.no-data-found", value: "No data found", comment: "Nothing was found by entered keyword (title)")
        case .errorFound:
            return NSLocalizedString("alert.error-found", value: "Error found", comment: "Some error occurred (title)")
        }
    }
    
    public var message: String {
        switch self {
        case .noKeyword:
            return NSLocalizedString("alert.no-keyword-message", value: "Please, enter some keyword", comment: "No keyword was entered (message)")
        case .noDataFound:
            return NSLocalizedString("alert.no-data-found-message", value: "Please, try another  keyword", comment: "Nothing was found by entered keyword (message)")
        default:
            return ""
        }
    }
}
