//
//  HTTPNetworkError.swift
//  GitSearch
//
//  Created by Vldmr on 8/27/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

// The enumeration defines possible errrors to encounter during Network Request
public enum HTTPNetworkError: String, Error {
    
    case parametersNil = "PARAMETERS_NIL"
    case headersNil = "HEADERS_NIL"
    case encodingFailed = "ENCODING_FAILED"
    case decodingFailed = "DECODING_FAILED"
    case missingURL = "MISSING_URL"
    case couldNotParse = "COULD_NOT_PARSE"
    case noData = "NO_DATA"
    case fragmentResponse = "FRAGMENT_RESPONSE"
    case unwrappingError = "UNWRAPPING_ERROR"
    case dataTaskFailed = "DATA_TASK_FAILED"
    case success = "SUCCESS"
    case authenticationError = "AUTHENTICATION_ERROR"
    case badRequest = "BAD_REQUEST"
    case pageNotFound = "PAGE_NOT_FOUND"
    case failed = "FAILED"
    case serverSideError = "SERVER_SIDE_ERROR"

}

extension HTTPNetworkError: LocalizedError {

    public var localizedDescription: String {
        return self.rawValue.localized(tableName: "Errors")
    }
    
}
