//
//  Strings.swift
//  GitSearch
//
//  Created by Volodymyr Mudrik on 26.03.2022.
//  Copyright © 2022 mudritskiy. All rights reserved.
//

import Foundation

public enum StringsLocalized {
    public enum Alerts {
        public enum Search {
            public enum Title {
                public static let noKeyword = NSLocalizedString(
                    "alert.no-keyword",
                    value: "No keyword",
                    comment: "No keyword was entered (title)"
                )
                public static let noDataFound = NSLocalizedString(
                    "alert.no-data-found",
                    value: "No data found",
                    comment: "Nothing was found by entered keyword (title)"
                )
                public static let errorFound = NSLocalizedString(
                    "alert.error-found",
                    value: "Error found",
                    comment: "Some error occurred (title)"
                )
            }
            public enum Message {
                public static let noKeyword = NSLocalizedString(
                    "alert.no-keyword-message",
                    value: "Please, enter some keyword",
                    comment: "No keyword was entered (message)"
                )
                public static let noDataFound = NSLocalizedString(
                    "alert.no-data-found-message",
                    value: "Please, try another  keyword",
                    comment: "Nothing was found by entered keyword (message)"
                )
                public static let errorFound = ""
            }
        }
    }

    public enum MainScreen {
        public static let labelGit = NSLocalizedString(
            "main.title-git",
            tableName: nil,
            bundle: .main,
            value: "GIT",
            comment: "Application title's left part. Don't need to be translate!"
        )
        public static let labelSearch = NSLocalizedString(
            "main.title-search",
            tableName: nil,
            bundle: .main,
            value: "SEARCH",
            comment: "Application title's right part. Don't need to be translate!"
        )
        public static let labelAbout = NSLocalizedString(
            "main.about",
            tableName: nil,
            bundle: .main,
            value: "Search information about any repository in github by keyword",
            comment: "About this application"
        )
        public static let inputText = NSLocalizedString(
            "main.enter-keyword",
            tableName: nil,
            bundle: .main,
            value: "Enter keyword",
            comment: "Enter keyword for search repositories"
        )
        public static let actionButtonTitle = NSLocalizedString(
            "main.search-button-title",
            tableName: nil,
            bundle: .main,
            value: "Search",
            comment: "Start repositories search"
        )
    }

    public enum SearchResult {
        public static let title = NSLocalizedString(
            "result-list.search-results",
            tableName: nil,
            bundle: Bundle.main,
            value: "Search results",
            comment: "Title for search result screen"
        )
    }

    public enum RepoInfo {
        public static let name = NSLocalizedString(
            "search-item.name",
            tableName: nil,
            bundle: .main,
            value: "name",
            comment: "repo's name"
        )
        public static let score = NSLocalizedString(
            "search-item.score",
            tableName: nil,
            bundle: .main,
            value: "score",
            comment: "repo's score"
        )
        public static let owner = NSLocalizedString(
            "search-item.owner",
            tableName: nil,
            bundle: .main,
            value: "owner",
            comment: "repo's owner"
        )
        public static let created = NSLocalizedString(
            "search-item.created",
            tableName: nil,
            bundle: .main,
            value: "created",
            comment: "repo's created at"
        )
        public static let updated = NSLocalizedString(
            "search-item.updated",
            tableName: nil,
            bundle: .main,
            value: "updated",
            comment: "repo's updated at"
        )
        public static let pushed = NSLocalizedString(
            "search-item.pushed",
            tableName: nil,
            bundle: .main,
            value: "pushed",
            comment: "repo's pushed at"
        )
        public static let language = NSLocalizedString(
            "search-item.language",
            tableName: nil,
            bundle: .main,
            value: "language",
            comment: "repo's language"
        )
        public static let url = NSLocalizedString(
            "search-item.url",
            tableName: nil,
            bundle: .main,
            value: "url",
            comment: "repo's html url"
        )
        public static let description = NSLocalizedString(
            "search-item.description",
            tableName: nil,
            bundle: .main,
            value: "description",
            comment: "repo's description"
        )
        public static let undefinedUser = NSLocalizedString(
            "search-item.undefined-user-warning",
            tableName: nil,
            bundle: .main,
            value: "undefined user",
            comment: "repo's user is nil"
        )
    }
}
