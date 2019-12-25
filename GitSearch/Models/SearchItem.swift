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
    
    subscript(index: Int) -> (name: String, value: String) {
        switch index {
        case 0:
            return (NSLocalizedString("search-item.name", tableName: nil, bundle: .main, value: "name", comment: "repo's name"), self.name ?? "")
        case 1:
            return (NSLocalizedString("search-item.score", tableName: nil, bundle: .main, value: "score", comment: "repo's score"), String(self.score))
        case 2:
            guard let login = self.owner?.login else {
                return (NSLocalizedString("search-item.owner", tableName: nil, bundle: .main, value: "owner", comment: "repo's owner"),
                        NSLocalizedString("search-item.undefined-user-warning", tableName: nil, bundle: .main, value: "undefined user", comment: "repo's user is nil") + " (id:\(self.id))")
            }
            return (NSLocalizedString("search-item.owner", tableName: nil, bundle: .main, value: "owner", comment: "repo's owner"), login + " (id:\(self.id))")
        case 3:
            return (NSLocalizedString("search-item.created", tableName: nil, bundle: .main, value: "created", comment: "repo's created at"), DateFormatter.MonthDayYear.string(from: self.created.value))
        case 4:
            return (NSLocalizedString("search-item.updated", tableName: nil, bundle: .main, value: "updated", comment: "repo's updated at"), DateFormatter.MonthDayYear.string(from: self.updated.value))
            
        case 5:
            return (NSLocalizedString("search-item.language", tableName: nil, bundle: .main, value: "language", comment: "repo's language"), self.language ?? "")
        case 6:
            return (NSLocalizedString("search-item.url", tableName: nil, bundle: .main, value: "url", comment: "repo's html url"), self.url ?? "")
        default:
            return (NSLocalizedString("search-item.description", tableName: nil, bundle: .main, value: "description", comment: "repo's description"), self.description ?? "")
        }
    }
}
