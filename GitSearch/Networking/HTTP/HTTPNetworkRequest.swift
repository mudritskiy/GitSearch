//
//  HTTPNetworkRequest.swift
//  GitSearch
//
//  Created by Vldmr on 8/27/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

public typealias HTTPParameters = [String: Any]
public typealias HTTPHeaders = [String: Any]

struct HTTPNetworkRequest {
    
    static var urlComponents: URLComponents = {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.github.com"
        return url
    }()
    
    static func configureHTTPRequest(
        from route: HTTPNetworkRoute,
        with parameters: HTTPParameters?,
        includes headers: HTTPHeaders?,
        contains body: Data?,
        and method: HTTPMethod
    ) throws -> URLRequest {
        
        urlComponents.path = route.rawValue
        guard let url = urlComponents.url else {
            throw HTTPNetworkError.missingURL
        }

        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30.0)
        
        request.httpMethod = method.rawValue
        request.httpBody = body
        try configureParametersAndHeaders(parameters: parameters, headers: headers, request: &request)
        return request
    }
    
    static func configureParametersAndHeaders(
        parameters: HTTPParameters?,
        headers: HTTPHeaders?,
        request: inout URLRequest
    ) throws {
        do {
            if let headers = headers {
                try URLEncoder.setHeaders(for: &request, with: headers)
            }
            if let parameters = parameters {
                try URLEncoder.encodeParameters(for: &request, with: parameters)
            }
        } catch {
            throw HTTPNetworkError.encodingFailed
        }
    }
    
}
