//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

struct SearchInfo {
    let total_count: String?
    let incomplete_results: String?
    let items: [item]?
}

struct item {
    let id: String?
    let name: String?
    let private: String?
    let html_url: Stirng?
    let description: String?
    let created_at: String?
    let updated_at: String?
    let language: String?
    let score: String?
    let owner: [owner]?
}

struct owner {
    let login: String?
    let id: String?
    let html_url: String?
}
class ViewController: UIViewController {

    fileprivate func oldVersionOfCode() {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //oldVersionOfCode()
        
        let outLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(outLabel)
        
        let urlQuery = "https://api.github.com/search/repositories?q=tetris&sort=stars&order=desc"
        guard let urlGit = URL(string: urlQuery) else { return }
        
        URLSession.shared.dataTask(with: urlGit) { data, response, error in
            if let response = response { outLabel.text = outLabel.text! + "/(response)" }
            guard let data = data else { return }
            
            do {
                let gitRepositories = try JSONDecoder().decode(SearchInfo.self, from: data);
                outLabel.text = outLabel.text! + " /(SearchInfo.total_count)"
            } catch {
                outLabel.text = outLabel.text! + "error"
            }
        }.resume()

    }

    func controlsCreate() {
    }
    
}

