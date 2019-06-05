//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        controlsCreate()
        
    }

    func controlsCreate() {
        let headerTitle = UILabel()
        headerTitle.text = "GIT"
        headerTitle.textAlignment = .right
        headerTitle.textColor = UIColor.white
        headerTitle.backgroundColor = UIColor.orange
        self.view.addSubview(headerTitle)
    }
    
}

