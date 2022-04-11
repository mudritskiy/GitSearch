//
//  PostService.swift
//  GitSearch
//
//  Created by Vldmr on 8/26/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

enum QuerySortItem: String {
    case stars
    case forks
    case updated
    case helpWantedIssues = "help-wanted-issues"
    case `default` = ""
}

enum QueryOrder: String {
    case desc
    case asc
}

struct SearchServices{
    typealias RequestResultHandler = (Result<SearchInfo, HTTPNetworkError>) -> ()
    
    static let shared = SearchServices()
    
    private let searchSession = URLSession(configuration: .default)
    
    func getRepositories(
        keysSequence: String,
        _ completion: @escaping RequestResultHandler
    ) {
        let requestData = RepositoriesRequest(
            keyWords: keysSequence,
            sort: .stars
        )

        do {
            let request = try HTTPNetworkRequest.configureHTTPRequest(
                from: requestData.path,
                with: requestData.queryItems(),
                and: requestData.method
            )
            let task = searchSession.dataTask(with: request) { (data, res, err) in
                guard let response = res as? HTTPURLResponse, let data = data else {
                    completion(.failure(.badRequest))
                    return
                }
                let result = HTTPNetworkResponse.handleNetworkResponse(for: response)
                switch result {
                    case .success:
                        let decoder = JSONDecoder()
                        let result = try? decoder.decode(SearchInfo.self, from: data)
                        completion(.success(result!))
                    case .failure(let err):
                        completion(.failure(err))
                }
            }
            task.resume()
            
        } catch {
            completion(.failure(.badRequest))
        }
    }
}
