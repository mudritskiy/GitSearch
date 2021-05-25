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
    let created: CustomDateJSON<RFC5322Date>
    let updated: CustomDateJSON<RFC5322Date>
    let language: String?
    let url: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, score, owner, language, description
        case created = "created_at"
        case updated = "updated_at"
        case url = "html_url"
    }

    struct Owners: Decodable {
        let login: String?
        let id: Int
        let url: String?
        
        enum CodingKeys: String, CodingKey {
            case login, id, url = "html_url"
        }
    }
}

extension SearchItem {

    static let maxPropertiesToDisplay: Int = 7 // last one is description

}
