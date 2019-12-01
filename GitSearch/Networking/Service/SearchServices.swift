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
    
    func getRepositories(keysSequence: String, _ completion: @escaping (Result<SearchInfo, HTTPNetworkError>) -> ()) {

        let parameters = [
            "q": keysSequence,
            "sort": "stars",
            "order": "desc"
        ]

        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .searchRepositories, with: parameters, includes: nil, contains: nil, and: .get)
            let task = searchSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let data = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(SearchInfo.self, from: data)
                        completion(Result.success(result!))
                        
                    case .failure(let err):
                        completion(Result.failure(err))
                    }
                }
            }
            task.resume()
            
        } catch {
            completion(Result.failure(HTTPNetworkError.badRequest))
        }
    }
    
    func getToken() {
        let parameters = [
            "scope": "public_repo+user",
            "note": "test",
            "client_id": "b55b4bdb66738f59f553",
            "client_secret": "7da7d104e8a9a90ecffaef63c8749558fdf4c859-u1eMLmVD8f72GUv"
        ]
        
        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .auth, with: parameters, includes: nil, contains: nil, and: .post)
            let task = searchSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let data = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(TokenRes.self, from: data)
                        print(result!)
//                        completion(Result.success(result!))
                        
                    case .failure(let err):
                        print(err.localizedDescription)
//                        completion(Result.failure(err))
                    }
                }
            }
            task.resume()
            
        } catch {
//            completion(Result.failure(HTTPNetworkError.badRequest))
        }

    }

    func getLimit() {
        let parameters = [String:String]()
//        let parameters = [
//            "scope": "public_repo+user",
//            "note": "test",
//            "client_id": "b55b4bdb66738f59f553",
//            "client_secret": "7da7d104e8a9a90ecffaef63c8749558fdf4c859-u1eMLmVD8f72GUv"
//        ]
        
        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(from: .rateLimit, with: parameters, includes: nil, contains: nil, and: .get)
            let task = searchSession.dataTask(with: request) { (data, res, err) in
                
                if let response = res as? HTTPURLResponse, let data = data {
                    let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                    switch result {
                    case .success:
                        let result = try? JSONDecoder().decode(RateLimit.self, from: data)
                        print(result!.resources.core)
                        print(result!.resources.search)
                        //                        completion(Result.success(result!))
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                        //                        completion(Result.failure(err))
                    }
                }
            }
            task.resume()
            
        } catch {
            //            completion(Result.failure(HTTPNetworkError.badRequest))
        }
        
    }

}

class TokenRes: Decodable {
    let token: String
    let token_last_eight: String
    let hashed_token: String
}

class RateLimit: Decodable {
    let resources: Resources
}

struct Resources: Decodable {
    
    struct Search: Decodable {
        let limit: Int
        let remaining: Int
        let reset: Int
    }
    
    let search: Search
    let core: Search
}
