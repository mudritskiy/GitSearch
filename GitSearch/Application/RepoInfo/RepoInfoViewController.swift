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
        let cellInfo = repInfo[indexPath.row]
        if indexPath.row == SearchItem.maxPropertiesToDisplay {
            let cell = tableView.dequeueReusableCell(withIdentifier: descriptionReuseId, for: indexPath) as! RepoInfoDescriptionCell
            cell.propertyValue.text = cellInfo.value
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: defaultReuseId, for: indexPath) as! RepoInfoCell
            cell.title.text = cellInfo.name
            cell.propertyValue.text = cellInfo.value
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
