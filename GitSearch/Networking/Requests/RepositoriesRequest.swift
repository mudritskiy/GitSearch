//
//  RepositoriesRequest.swift
//  GitSearch
//
//  Created by Volodymyr Mudrik on 09.04.2022.
//  Copyright © 2022 mudritskiy. All rights reserved.
//

import Foundation

struct RepositoriesRequest {
    let keyWords: String
    let sort: QuerySortItem
    let order: QueryOrder
    let perPage: UInt8
    let page: UInt

    let path: HTTPNetworkRoute = .searchRepositories
    let method: HTTPMethod = .get

    init(
        keyWords: String,
        sort: QuerySortItem = .default,
        order: QueryOrder = .desc,
        perPage: UInt8 = 30,
        page: UInt = 1
    ) {
        self.keyWords = keyWords
        self.sort = sort
        self.order = order
        self.perPage = min(perPage, 100)
        self.page = max(1, page)
    }

    func queryItems() -> [String: String] {
        [
            "q": keyWords,
            "sort": sort.rawValue,
            "order": order.rawValue,
            "per_page": String(perPage),
            "page": String(page)
        ]
    }
}
