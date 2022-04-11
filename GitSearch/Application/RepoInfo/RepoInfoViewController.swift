//
//  CellDetailTableView.swift
//  GitSearch
//
//  Created by Vldmr on 7/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

// MARK: - Repo information
// Table view is not required here, more for variety
class RepoInfoViewController: UITableViewController {
    private let _defaultReuseId = "default"
    private let _descriptionReuseId = "description"

    private let _screenTitle: String
    private let _data: [RepoField]

    // MARK: - Init
    init(item: SearchItem) {
        _data = [
            RepoField(.name, value: item.fullName),
            RepoField(.owner, value: item.owner?.login, default: StringsLocalized.RepoInfo.undefinedUser + " (id:\(item.id))"),
            RepoField(.language, value: item.language),
            RepoField(.created, value: DateFormatter.MonthDayYear.string(from: item.created.value)),
            RepoField(.updated, value: DateFormatter.MonthDayYear.string(from: item.updated.value)),
            RepoField(.url, value: item.url),
            RepoField(.description, value: item.description),
        ]
        _screenTitle = item.name ?? ""
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
        
        navigationItem.title = _screenTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = _data[indexPath.row]
        switch item.name {
            case .description:
                let cell = tableView.dequeueReusableCell(withIdentifier: _descriptionReuseId, for: indexPath) as! RepoInfoDescriptionCell
                cell.setup(with: item)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: _defaultReuseId, for: indexPath) as! RepoInfoCell
                cell.setup(with: item)
                return cell
        }
    }
}
