//
//  RepoField.swift
//  GitSearch
//
//  Created by Volodymyr Mudrik on 11.04.2022.
//  Copyright © 2022 mudritskiy. All rights reserved.
//

import Foundation

enum RepoFieldName: String {
    case name
    case owner
    case language
    case created
    case updated
    case url
    case description

    var localized: String {
        switch self {
            case .name:
                return StringsLocalized.RepoInfo.name
            case .owner:
                return StringsLocalized.RepoInfo.owner
            case .language:
                return StringsLocalized.RepoInfo.language
            case .created:
                return StringsLocalized.RepoInfo.created
            case .updated:
                return StringsLocalized.RepoInfo.updated
            case .url:
                return StringsLocalized.RepoInfo.url
            case .description:
                return StringsLocalized.RepoInfo.description
        }
    }
}

struct RepoField {
    let name: RepoFieldName
    let value: String

    init(_ name: RepoFieldName, value: String?, default defaultValue: String = "") {
        self.name = name
        self.value = value ?? defaultValue
    }
}
