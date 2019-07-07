//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    let inputText = UITextView()
    
    fileprivate func setupSubviews() {
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
        
        inputText.frame = CGRect(x: 10, y: borderTop+labelSeparator.height+20, width: viewWidth-10, height: 20)
        inputText.backgroundColor = UIColor.lightGray
        view.addSubview(inputText)
        
        let actionButton = UIButton(type: .system)
        actionButton.frame = CGRect(x: 10, y: borderTop+labelSeparator.height+60, width: 100, height: 20)
        actionButton.backgroundColor = UIColor.green
        actionButton.setTitle("Search", for: .normal)
        actionButton.addTarget(self, action: #selector(SearchController.buttonAction(_:)), for: .touchUpInside)
        view.addSubview(actionButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.white
        
        setupSubviews()

    }
    
    func fetchRepositoriesHeader(from urlString: String, completion: @escaping (SearchInfo) -> ()) {
        
        guard let urlGit = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: urlGit) { data, response, error in
            if error != nil { return }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { return }
            guard let mime = httpResponse.mimeType, mime == "application/json" else { return }
            guard let data = data else { return }
            do {
                let gitRep = try JSONDecoder().decode(SearchInfo.self, from: data)
                completion(gitRep)
            } catch let errorLbl {
                print(errorLbl)
            }
        }
        task.resume()
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        
        guard let keyWord = inputText.text else {
            return
        }
        
        let urlQuery = "https://api.github.com/search/repositories?q="+keyWord+"&sort=stars&order=desc"
        fetchRepositoriesHeader(from: urlQuery) { gitRep in
          DispatchQueue.main.async {
            let newVC = HomeController(collectionViewLayout: UICollectionViewFlowLayout() )
            newVC.gitRep = gitRep
            self.navigationController?.pushViewController(newVC, animated: true)
            }
        }

    }
}
