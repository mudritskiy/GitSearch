//
//  CellDetailTableView.swift
//  GitSearch
//
//  Created by Vldmr on 7/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoViewController: UITableViewController {
    
    private let cellId = "id"
    var repInfo = [String: String]()
    var props = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(RepoInfoCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        navigationItem.title = repInfo["name"]

        if let indexName = props.firstIndex(of: "name") { props.remove(at: indexName) }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = props[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RepoInfoCell
        cell.textLabel?.text = key.replacingOccurrences(of: "_", with: " ") + ": " + repInfo[key]!
        cell.textLabel?.numberOfLines = 0
        return cell
    }
}


