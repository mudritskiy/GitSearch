//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITextFieldDelegate {
    
    fileprivate var labelGitWidth = 0
    
    let labelGit: PaddedLabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = PaddedLabel()
        label.text = "GIT"
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.layer.backgroundColor = UIColor(red: 241/255, green: 104/255, blue: 88/255, alpha: 1.0).cgColor
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSearch: PaddedLabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = PaddedLabel()
        label.text = "SEARCH"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.layer.backgroundColor = UIColor(red: 108/255, green: 94/255, blue: 82/255, alpha: 1.0).cgColor
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "Search information about any repository in github by keyword"
        return label
    }()

    let inputText: PaddedText = {
        let textView = PaddedText()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0).cgColor
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1
        textView.backgroundColor = UIColor.white
        textView.keyboardType = .default
        textView.placeholder = "Enter keyword"
        textView.borderStyle = .none
        textView.clearButtonMode = .whileEditing
        return textView
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor(red: 241/255, green: 104/255, blue: 88/255, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(SearchController.buttonAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // muts be global `cause used in several places
    func roundCorners(viewToRound: UIView, cornerRadius: Double, cornerMask: CACornerMask) {
        viewToRound.layer.cornerRadius = CGFloat(cornerRadius)
        viewToRound.layer.maskedCorners = cornerMask
    }

    fileprivate func setupSubviews() {

        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        
        view.addSubview(labelGit)
        view.addSubview(labelSearch)
        view.addSubview(inputText)
        view.addSubview(actionButton)
        
        inputText.delegate = self
        
        let titleSize: CGFloat = 40
//        let backgroundBorderSize: CGFloat = 25
        roundCorners(viewToRound: labelGit, cornerRadius: Double(titleSize)/2, cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
        roundCorners(viewToRound: labelSearch, cornerRadius: Double(titleSize)/2, cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])


        let constraints = [
            labelGit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            labelGit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: titleSize),
            labelGit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            labelGit.heightAnchor.constraint(equalToConstant: titleSize),
            
            labelSearch.topAnchor.constraint(equalTo: labelGit.topAnchor, constant: 0),
            labelSearch.leadingAnchor.constraint(equalTo: labelGit.trailingAnchor, constant: 1),
            labelSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -titleSize),
            labelSearch.heightAnchor.constraint(equalToConstant: titleSize),
            
            inputText.topAnchor.constraint(equalTo: labelGit.bottomAnchor, constant: 50),
            inputText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            inputText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            inputText.heightAnchor.constraint(equalToConstant: CGFloat(40)),
            
            actionButton.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: inputText.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: inputText.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: CGFloat(40))
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.white
        setupSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
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
    
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {alert.dismiss(animated: true, completion: nil)})
    }
    
    func showHideSpinner(spinner child: SpinnerViewController, _ show: Bool = true) {
        if show {
            addChild(child)
            child.view.frame = view.frame
            view.addSubview(child.view)
            child.didMove(toParent: self)
        } else {
            child.willMove(toParent: self)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
    @objc func buttonAction(_ sender: UIButton!) {
        
        guard let keyWords = inputText.text else { return }
        
        if keyWords.isEmpty {
            postAlert(title: "No keyword", message: "Please, enter some keyword")
            return
        }
        
        let child = SpinnerViewController()
        showHideSpinner(spinner: child)
        
        let keys = keyWords.components(separatedBy: " ")
//        keys.forEach({key in keys[keys.firstIndex(of: key)!] = "topic:"+key})
        let keysSequence = keys.joined(separator: "+")

        let urlQuery = "https://api.github.com/search/repositories?q="+keysSequence+"&sort=stars&order=desc"
        fetchRepositoriesHeader(from: urlQuery) { gitRep in
            DispatchQueue.main.async {
                self.showHideSpinner(spinner: child, false)
                if gitRep.total_count == 0 {
                    self.postAlert(title: "No data found", message: "Please, try another  keyword")
                } else {
                    let newVC = SearchResultViewController(collectionViewLayout: UICollectionViewFlowLayout())
                    newVC.gitRep = gitRep
                    self.navigationController?.pushViewController(newVC, animated: true)
                }
            }
        }

    }
    
}





