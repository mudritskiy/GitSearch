//
//  CellController.swift
//  GitSearch
//
//  Created by Vldmr on 7/2/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class CellController: UIViewController {
    
    let label: UITextView = {
        let label = UITextView()
        label.text = "TEST TEST TEST TEST"
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
