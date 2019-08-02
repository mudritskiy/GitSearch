//
//  SearchInfo.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

class SearchInfo: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: Array<SearchItem>?
}
