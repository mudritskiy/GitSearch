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
    
    case parametersNil
    case headersNil
    case encodingFailed
    case decodingFailed
    case missingURL
    case couldNotParse
    case noData
    case fragmentResponse
    case unwrappingError
    case dataTaskFailed
    case success
    case authenticationError
    case badRequest
    case pageNotFound
    case failed
    case serverSideError

}

extension HTTPNetworkError {
    
    public var localizedDescription: String {
        switch self {
        case .parametersNil:
            return NSLocalizedString("PARAMETERS_NIL", tableName: "NetworkErrors", value: "Parameters are Nil", comment: "")
        case .headersNil:
            return NSLocalizedString("HEADERS_NIL", tableName: "NetworkErrors", value: "Headers are Nil", comment: "")
        case .encodingFailed:
            return NSLocalizedString("ENCODING_FAILED", tableName: "NetworkErrors", value: "Parameter Encoding failed", comment: "")
        case .decodingFailed:
            return NSLocalizedString("DECODING_FAILED", tableName: "NetworkErrors", value: "Unable to Decode the data", comment: "")
        case .missingURL:
            return NSLocalizedString("MISSING_URL", tableName: "NetworkErrors", value: "The URL is nil", comment: "")
        case .couldNotParse:
            return NSLocalizedString("COULD_NOT_PARSE", tableName: "NetworkErrors", value: "Unable to parse the JSON response", comment: "")
        case .noData:
            return NSLocalizedString("NO_DATA", tableName: "NetworkErrors", value: "The data from API is Nil", comment: "")
        case .fragmentResponse:
            return NSLocalizedString("FRAGMENT_RESPONSE", tableName: "NetworkErrors", value: "The API's response's body has fragments", comment: "")
        case .unwrappingError:
            return NSLocalizedString("UNWRAPPING_ERROR", tableName: "NetworkErrors", value: "Unable to unwrape the data", comment: "")
        case .dataTaskFailed:
            return NSLocalizedString("DATA_TASK_FAILED", tableName: "NetworkErrors", value: "The Data Task object failed", comment: "")
        case .success:
            return NSLocalizedString("SUCCESS", tableName: "NetworkErrors", value: "Successful Network Request", comment: "")
        case .authenticationError:
            return NSLocalizedString("AUTHENTICATION_ERROR", tableName: "NetworkErrors", value: "You must be Authenticated", comment: "")
        case .badRequest:
            return NSLocalizedString("BAD_REQUEST", tableName: "NetworkErrors", value: "Bad Request", comment: "")
        case .pageNotFound:
            return NSLocalizedString("PAGE_NOT_FOUND", tableName: "NetworkErrors", value: "Page/Route rquested not found.", comment: "")
        case .failed:
            return NSLocalizedString("FAILED", tableName: "NetworkErrors", value: "Network Request failed", comment: "")
        case .serverSideError:
            return NSLocalizedString("SERVER_SIDE_ERROR", tableName: "NetworkErrors", value: "Server error", comment: "")
        }
    }
}
