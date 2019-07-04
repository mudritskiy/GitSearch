//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.white
        
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let borderTop = 100
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
        
        let inputText = UITextView(frame: CGRect(x: 10, y: borderTop+labelSeparator.height+20, width: viewWidth-10, height: 20))
        inputText.backgroundColor = UIColor.lightGray
        view.addSubview(inputText)
        
        let actionButton = UIButton(type: .system)
        actionButton.frame = CGRect(x: 10, y: borderTop+labelSeparator.height+60, width: 100, height: 20)
        actionButton.backgroundColor = UIColor.green
        actionButton.setTitle("Search", for: .normal)
        actionButton.addTarget(self, action: #selector(SearchController.buttonAction(_:)), for: .touchUpInside)
        view.addSubview(actionButton)

    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        let newVC = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(newVC, animated: true)
    }
}
