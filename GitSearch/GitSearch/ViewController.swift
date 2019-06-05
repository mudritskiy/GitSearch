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
        
        let labelSeparator = (width: Int(self.view.frame.size.width/3), height: 200)
        
        let headerTitle = UILabel(frame: CGRect(x: 0, y: 0, width: labelSeparator.width, height: labelSeparator.height))
        headerTitle.text = "GIT"
        headerTitle.textAlignment = .right
        headerTitle.textColor = UIColor.white
        headerTitle.backgroundColor = UIColor.orange
        self.view.addSubview(headerTitle)

        let headerTitle2 = UILabel(frame: CGRect(x: labelSeparator.width, y: 0, width: (Int(self.view.frame.size.width) - labelSeparator.width), height: labelSeparator.height))
        headerTitle2.text = "SEARCH"
        headerTitle2.textAlignment = .left
        headerTitle2.textColor = UIColor.white
        headerTitle2.backgroundColor = UIColor.blue
        self.view.addSubview(headerTitle2)

    }

    func controlsCreate() {
    }
    
}

