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
        
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let borderTop = 20
        let viewWidth = Int(self.view.frame.size.width)
        let labelSeparator = (width: Int(viewWidth/3), height: 50)
        
        let labelGit = UILabel(frame: CGRect(x: 0, y: borderTop, width: labelSeparator.width, height: labelSeparator.height))
        labelGit.text = "GIT"
        labelGit.textAlignment = .right
        labelGit.textColor = UIColor.white
        labelGit.backgroundColor = UIColor(red:0.98, green:0.56, blue:0.04, alpha:1.0) // orange
        labelGit.font = lableFont
        self.view.addSubview(labelGit)

        let labelSearch = UILabel(frame: CGRect(x: labelSeparator.width, y: borderTop, width: (viewWidth - labelSeparator.width), height: labelSeparator.height))
        labelSearch.text = "SEARCH"
        labelSearch.textAlignment = .left
        labelSearch.textColor = UIColor.white
        labelSearch.backgroundColor = UIColor(red:0.41, green:0.56, blue:0.81, alpha:1.0) // blue
        labelSearch.font = lableFont
        self.view.addSubview(labelSearch)

    }

    func controlsCreate() {
    }
    
}

