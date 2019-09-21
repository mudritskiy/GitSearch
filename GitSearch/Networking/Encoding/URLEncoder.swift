//
//  URLEncoder.swift
//  GitSearch
//
//  Created by Vldmr on 8/26/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

public struct URLEncoder {
    
    static func encodeParameters(for urlRequest: inout URLRequest, with parameters: HTTPParameters?) throws {
        guard let url = urlRequest.url else { throw HTTPNetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        
    }
    
    static func setHeaders(for urlRequest: inout URLRequest, with headers: HTTPHeaders?) throws {
        if let headers = headers {
            headers.forEach { (key, value) in
                urlRequest.setValue(value as? String, forHTTPHeaderField: key)
            }
        }
    }
}
