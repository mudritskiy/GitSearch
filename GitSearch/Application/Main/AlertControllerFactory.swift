//
//  SearchViewText.swift
//  GitSearch
//
//  Created by Vldmr on 9/28/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation
import UIKit

public enum SearchUserAlerts: String {
    case noKeyword
    case noDataFound
    case errorFound
}

public final class AlertControllerFactory {

    func makeAlertController(alert: SearchUserAlerts) -> UIAlertController {
        let alertProps = _alertProps(alert)
        return UIAlertController(
            title: alertProps.title,
            message: alertProps.message,
            preferredStyle: .alert
        )
    }

    private func _alertProps(_ alert: SearchUserAlerts) -> (title: String, message: String) {
        switch alert {
            case .noKeyword:
                return (
                    title: StringsLocalized.Alerts.Search.Title.noKeyword,
                    message: StringsLocalized.Alerts.Search.Message.noKeyword
                )
            case .noDataFound:
                return (
                    title: StringsLocalized.Alerts.Search.Title.noKeyword,
                    message: StringsLocalized.Alerts.Search.Message.noKeyword
                )
            case .errorFound:
                return (
                    title: StringsLocalized.Alerts.Search.Title.noKeyword,
                    message: StringsLocalized.Alerts.Search.Message.noKeyword
                )
        }
    }
}
