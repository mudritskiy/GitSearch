//
//  HTTPNetworkResponse.swift
//  GitSearch
//
//  Created by Vldmr on 8/27/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

struct HTTPNetworkResponse {
    
    static func handleNetworkResponse(for response: HTTPURLResponse?) -> Result<String, Error>{
        
        guard let res = response else { return Result.failure(HTTPNetworkError.unwrappingError)}

        switch res.statusCode {
        case 200...299: return Result.success(HTTPNetworkError.success.rawValue)
        case 401: return Result.failure(HTTPNetworkError.authenticationError)
        case 400...499: return Result.failure(HTTPNetworkError.badRequest)
        case 500...599: return Result.failure(HTTPNetworkError.serverSideError)
        default: return Result.failure(HTTPNetworkError.failed)
        }
    }
}
