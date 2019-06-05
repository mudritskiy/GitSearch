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
        
        let borderTop = 20
        let viewWidth = Int(self.view.frame.size.width)
        let labelSeparator = (width: Int(viewWidth/3), height: 100)
        
        let headerTitle = UILabel(frame: CGRect(x: 0, y: borderTop, width: labelSeparator.width, height: labelSeparator.height))
        headerTitle.text = "GIT"
        headerTitle.textAlignment = .right
        headerTitle.textColor = UIColor.white
        headerTitle.backgroundColor = UIColor.orange
        headerTitle.font = UIFont.boldSystemFont(ofSize: 17)
        self.view.addSubview(headerTitle)

        let headerTitle2 = UILabel(frame: CGRect(x: labelSeparator.width, y: borderTop, width: (viewWidth - labelSeparator.width), height: labelSeparator.height))
        headerTitle2.text = "SEARCH"
        headerTitle2.textAlignment = .left
        headerTitle2.textColor = UIColor.black
        headerTitle2.backgroundColor = UIColor.white
        headerTitle.font = UIFont.boldSystemFont(ofSize: 17)
        self.view.addSubview(headerTitle2)

    }

    func controlsCreate() {
    }
    
}

