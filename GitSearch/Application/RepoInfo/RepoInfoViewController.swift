//
//  CellDetailTableView.swift
//  GitSearch
//
//  Created by Vldmr on 7/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoViewController: UITableViewController {
    
    private let cellId = "common"
    private let cellDescription = "description"
    private var repInfo = [String: String]()
    private var props = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(RepoInfoCell.self, forCellReuseIdentifier: cellId)
        tableView.register(RepoInfoDescriptionCell.self, forCellReuseIdentifier: cellDescription)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        navigationItem.title = repInfo["name"]

        if let indexName = props.firstIndex(of: "name") {
            props.remove(at: indexName)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = props[indexPath.row]
        if key == cellDescription {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellDescription, for: indexPath) as! RepoInfoDescriptionCell
            cell.propertyValue.text = repInfo[key]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoInfoCell
            cell.title.text = key.replacingOccurrences(of: "_", with: " ")
            cell.propertyValue.text = repInfo[key]
            return cell
        }
    }
    
    init(properties: [String], item: Dictionary<String, String>) {
        super.init(nibName: nil, bundle: nil)
        props = properties
        properties.forEach { prop in
            repInfo[prop] = item[prop]
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
