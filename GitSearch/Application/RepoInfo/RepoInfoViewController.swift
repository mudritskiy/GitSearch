//
//  CellDetailTableView.swift
//  GitSearch
//
//  Created by Vldmr on 7/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoViewController: UITableViewController {
    
    private let defaultReuseId = "default"
    private let descriptionReuseId = "description"
    private var repInfo: SearchItem

    let filesNames = [
        NSLocalizedString("search-item.name", tableName: nil, bundle: .main, value: "name", comment: "repo's name"),
        NSLocalizedString("search-item.score", tableName: nil, bundle: .main, value: "score", comment: "repo's score"),
        NSLocalizedString("search-item.owner", tableName: nil, bundle: .main, value: "owner", comment: "repo's owner"),
        NSLocalizedString("search-item.created", tableName: nil, bundle: .main, value: "created", comment: "repo's created at"),
        NSLocalizedString("search-item.updated", tableName: nil, bundle: .main, value: "updated", comment: "repo's updated at"),
        NSLocalizedString("search-item.language", tableName: nil, bundle: .main, value: "language", comment: "repo's language"),
        NSLocalizedString("search-item.url", tableName: nil, bundle: .main, value: "url", comment: "repo's html url"),
        NSLocalizedString("search-item.description", tableName: nil, bundle: .main, value: "description", comment: "repo's description")
    ]
    
    typealias ResultClosure<T> = (T) -> String

    let valuesList: Array<ResultClosure<SearchItem>> = [
        {$0.name ?? ""},
        {String($0.score)},
        { item in if let login = item.owner?.login { return login } else { return
            NSLocalizedString("search-item.undefined-user-warning", tableName: nil, bundle: .main, value: "undefined user", comment: "repo's user is nil") + " (id:\(item.id))" }
            },
        {DateFormatter.MonthDayYear.string(from: $0.created.value)},
        {DateFormatter.MonthDayYear.string(from: $0.updated.value)},
        {$0.language ?? ""},
        {$0.url ?? ""},
        {$0.description ?? ""}
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(RepoInfoCell.self, forCellReuseIdentifier: defaultReuseId)
        tableView.register(RepoInfoDescriptionCell.self, forCellReuseIdentifier: descriptionReuseId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        navigationItem.title = repInfo.name
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchItem.maxPropertiesToDisplay + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let propertyValueClousure = valuesList[indexPath.row]
        
        if indexPath.row == SearchItem.maxPropertiesToDisplay {
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionReuseId, for: indexPath) as! RepoInfoDescriptionCell
            cell.propertyValue.text = propertyValueClousure(repInfo)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: defaultReuseId, for: indexPath) as! RepoInfoCell
            cell.title.text = filesNames[indexPath.row]
            cell.propertyValue.text = propertyValueClousure(repInfo)
            return cell
        }
    }
    
    init(item: SearchItem) {
        repInfo = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

