//
//  SearchInfo.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

class SearchInfo: Decodable {
    let items: Array<SearchItem>?
    let incomplete_results: Bool

    var isEmpty: Bool { items?.isEmpty ?? true }
}
