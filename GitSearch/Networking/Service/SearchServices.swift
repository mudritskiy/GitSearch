//
//  PostService.swift
//  GitSearch
//
//  Created by Vldmr on 8/26/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

struct SearchServices{
    
    static let shared = SearchServices()
    
    let searchSession = URLSession(configuration: .default)
    
    func getRepositories(keysSequence: String, _ completion: @escaping (Result<SearchInfo?>) -> ()) {

        let parameters = [
            "q": keysSequence,
            "sort": "stars",
            "order": "desc"
        ]

        do{
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .searchRepositories, with: parameters, includes: nil, contains: nil, and: .get)
            searchSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let unwrappedData = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(SearchInfo.self, from: unwrappedData)
                        completion(Result.success(result))
                        
                    case .failure:
                        completion(Result.failure(HTTPNetworkError.decodingFailed))
                    }
                }
                }.resume()
        }catch{
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
}
