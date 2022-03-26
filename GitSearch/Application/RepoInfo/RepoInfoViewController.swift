//
//  CellDetailTableView.swift
//  GitSearch
//
//  Created by Vldmr on 7/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoViewController: UITableViewController {
    typealias ResultClosure<T> = (T) -> String

    private let _defaultReuseId = "default"
    private let _descriptionReuseId = "description"
    private var _repInfo: SearchItem

    let items: [(String, ResultClosure<SearchItem>)] = [
        (StringsLocalized.RepoInfo.name, {$0.name ?? ""}),
        (StringsLocalized.RepoInfo.score, {String($0.score)}),
        (StringsLocalized.RepoInfo.owner, { $0.owner?.login ??
            StringsLocalized.RepoInfo.undefinedUser + " (id:\($0.id))" }),
        (StringsLocalized.RepoInfo.created, {DateFormatter.MonthDayYear.string(from: $0.created.value)}),
        (StringsLocalized.RepoInfo.updated, {DateFormatter.MonthDayYear.string(from: $0.updated.value)}),
        (StringsLocalized.RepoInfo.language, {$0.language ?? ""}),
        (StringsLocalized.RepoInfo.url, {$0.url ?? ""}),
        (StringsLocalized.RepoInfo.description, {$0.description ?? ""}),
    ]

    // MARK: - Init
    init(item: SearchItem) {
        _repInfo = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(RepoInfoCell.self, forCellReuseIdentifier: _defaultReuseId)
        tableView.register(RepoInfoDescriptionCell.self, forCellReuseIdentifier: _descriptionReuseId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        navigationItem.title = _repInfo.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchItem.maxPropertiesToDisplay + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let propertyValueClousure = items[indexPath.row].1
        
        if indexPath.row == SearchItem.maxPropertiesToDisplay {
            let cell = tableView.dequeueReusableCell(withIdentifier: _descriptionReuseId, for: indexPath) as! RepoInfoDescriptionCell
            cell.propertyValue.text = propertyValueClousure(_repInfo)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: _defaultReuseId, for: indexPath) as! RepoInfoCell
            cell.title.text = items[indexPath.row].0
            cell.propertyValue.text = propertyValueClousure(_repInfo)
            return cell
        }
    }
}
