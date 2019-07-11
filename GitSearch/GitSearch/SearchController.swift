//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchController: UIViewController {
    
    let inputText: UITextView = {
        let textView = UITextView()
//        textView.frame = CGRect(x: 10, y: borderTop+labelSeparator.height+20, width: viewWidth-10, height: 20)
        textView.backgroundColor = UIColor.lightGray
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
//    let viewWidth = Int(self.view.frame.size.width)

    let labelGit: UILabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = UILabel()
        label.text = "GIT"
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red:0.98, green:0.56, blue:0.04, alpha:1.0) // orange
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSearch: UILabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = UILabel()
        label.text = "SEARCH"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red:0.41, green:0.56, blue:0.81, alpha:1.0) // blue
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    fileprivate func setupSubviews() {
        let viewWidth = Int(self.view.frame.size.width)
        let labelSeparator = (width: Int(viewWidth/3), height: 50)
        let borderTop = 100

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
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(labelGit)
        view.addSubview(labelSearch)
        view.addSubview(inputText)
        
//        let borderTop = 100
        let viewWidth = Int(self.view.frame.size.width)
        let margins = view.layoutMarginsGuide
        let constraints = [
            labelGit.topAnchor.constraint(equalTo: margins.topAnchor),
            labelGit.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelGit.widthAnchor.constraint(equalToConstant: CGFloat(viewWidth/3)),
            labelGit.heightAnchor.constraint(equalToConstant: CGFloat(50)),
            
            labelSearch.topAnchor.constraint(equalTo: margins.topAnchor),
            labelSearch.leadingAnchor.constraint(equalTo: labelGit.trailingAnchor),
            labelSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelSearch.heightAnchor.constraint(equalToConstant: CGFloat(50)),
            
            inputText.topAnchor.constraint(equalTo: labelGit.bottomAnchor, constant: 50),
            inputText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            inputText.widthAnchor.constraint(equalToConstant: CGFloat(200)),
            inputText.heightAnchor.constraint(equalToConstant: CGFloat(50))
        ]
        
        NSLayoutConstraint.activate(constraints)
        
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
