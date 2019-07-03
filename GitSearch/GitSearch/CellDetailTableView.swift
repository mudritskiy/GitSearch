//
//  CellDetailTableView.swift
//  GitSearch
//
//  Created by Vldmr on 7/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class CellDetailTableView: UITableViewController {
    
    fileprivate let cellId = "id"
    var repInfo = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(InfoCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! InfoCell
        let key = Array(repInfo.keys)[indexPath.row]
        cell.title.text = key + ": " + repInfo[key]!
        return cell
    }
}

class InfoCell: UITableViewCell {
    
    let title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(title)
        title.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
