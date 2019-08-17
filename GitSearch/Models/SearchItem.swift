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

    func ToArray(props: inout [String]) -> Dictionary<String, String> {
        var result = [String: String]()
        var childValue: String?
        let propsFilled = props.count != 0
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        
        let mirror = Mirror(reflecting: self)
        for child in mirror.children  {
            let childKey = child.label!
            if childKey != "owner" {
                if let value = child.value as? Int {
                    childValue = String(value)
                }
                else if let value = child.value as? Double {
                    childValue = String(value)
                }
                else if let value = child.value as? String {
                    if let date: Date = dateFormatterGet.date(from: value) {
                        childValue = dateFormatter.string(from: date)
                    } else {
                        childValue = value
                    }
                }
                else {childValue = ""}
            } else {
                childValue = (child.value as! Owners).login!
            }
            if !propsFilled {
                props.append(childKey)
            }
            result[childKey] = childValue
        }
        return result
    }
    
}

struct Owners: Decodable {
    let login: String?
    let id: Int
    let html_url: String?
}
