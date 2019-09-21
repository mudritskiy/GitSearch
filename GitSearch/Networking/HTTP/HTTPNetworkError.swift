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

extension HTTPNetworkError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .parametersNil:
            return NSLocalizedString("Parameters are nil.", comment: "")
        case .headersNil:
            return NSLocalizedString("Headers are Nil", comment: "")
        case .encodingFailed:
            return NSLocalizedString("Parameter Encoding failed.", comment: "")
        case .decodingFailed:
            return NSLocalizedString("Unable to Decode the data.", comment: "")
        case .missingURL:
            return NSLocalizedString("The URL is nil.", comment: "")
        case .couldNotParse:
            return NSLocalizedString("Unable to parse the JSON response.", comment: "")
        case .noData:
            return NSLocalizedString("The data from API is Nil.", comment: "")
        case .fragmentResponse:
            return NSLocalizedString("The API's response's body has fragments.", comment: "")
        case .unwrappingError:
            return NSLocalizedString("Unable to unwrape the data.", comment: "")
        case .dataTaskFailed:
            return NSLocalizedString("The Data Task object failed.", comment: "")
        case .success:
            return NSLocalizedString("Successful Network Request", comment: "")
        case .authenticationError:
            return NSLocalizedString("You must be Authenticated", comment: "")
        case .badRequest:
            return NSLocalizedString("Bad Request", comment: "")
        case .pageNotFound:
            return NSLocalizedString("Page/Route rquested not found.", comment: "")
        case .failed:
            return NSLocalizedString("Network Request failed", comment: "")
        case .serverSideError:
            return NSLocalizedString("Server error", comment: "")
        }
    }
}
