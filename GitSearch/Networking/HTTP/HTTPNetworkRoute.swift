//
//  HTTPNetworkRoutes.swift
//  GitSearch
//
//  Created by Vldmr on 8/26/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

public enum HTTPNetworkRoute: String {
    case searchRepositories = "/search/repositories"
    case auth = "/authorizations/"
    case rateLimit = "/rate_limit"
}
