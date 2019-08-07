//
//  SearchItem.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation

class SearchItem: Decodable {
    let id: Int
    let name: String?
    let score: Double
    let owner: Owners?
    let created_at: String?
    let updated_at: String?
    let language: String?
    let html_url: String?
    let description: String?
}

struct Owners: Decodable {
    let login: String?
    let id: Int
    let html_url: String?
}
