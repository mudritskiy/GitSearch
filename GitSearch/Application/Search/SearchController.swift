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
        label.backgroundColor = UIColor(red: 0/255, green: 159/255, blue: 214/255, alpha: 1.0)
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let inputText: PaddedText = {
        let textView = PaddedText()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 5
        textView.layer.borderWidth = 1
        textView.keyboardType = .default
        textView.placeholder = "Enter keyword"
        textView.borderStyle = .roundedRect
        textView.clearButtonMode = .whileEditing
        return textView
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor(red: 0/255, green: 134/255, blue: 214/255, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(red: 0/255, green: 154/255, blue: 244/255, alpha: 1.0).cgColor
        button.layer.borderWidth = 1
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(SearchController.buttonAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate func setupSubviews() {

        view.addSubview(labelGit)
        view.addSubview(labelSearch)
        view.addSubview(inputText)
        view.addSubview(actionButton)
        
        inputText.delegate = self
//        inputText.becomeFirstResponder()
        
        let constraints = [
            labelGit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelGit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            labelGit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            labelGit.heightAnchor.constraint(equalToConstant: CGFloat(50)),
            
            labelSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            labelSearch.leadingAnchor.constraint(equalTo: labelGit.trailingAnchor),
            labelSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelSearch.heightAnchor.constraint(equalToConstant: CGFloat(50)),
            
            inputText.topAnchor.constraint(equalTo: labelGit.bottomAnchor, constant: 50),
            inputText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            inputText.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),
            inputText.heightAnchor.constraint(equalToConstant: CGFloat(40)),
            
            actionButton.topAnchor.constraint(equalTo: inputText.topAnchor),
            actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            actionButton.widthAnchor.constraint(equalToConstant: CGFloat(70)),
            actionButton.heightAnchor.constraint(equalToConstant: CGFloat(40))
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view?.backgroundColor = UIColor.white
        
        setupSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
        let keysSequence = keys.joined(separator: "+")
        
        SearchServices.shared.getRepositories(keysSequence: keysSequence) { res in
            DispatchQueue.main.async {
                self.showHideSpinner(spinner: child, false)
                switch res {
                case .success(let gitRep):
                    if gitRep!.total_count == 0 {
                        self.postAlert(title: "No data found", message: "Please, try another  keyword")
                    } else {
                        let newVC = SearchResultViewController(collectionViewLayout: UICollectionViewFlowLayout())
                        newVC.gitRep = gitRep
                        self.navigationController?.pushViewController(newVC, animated: true)
                    }
                case .failure(let err):
                    print("Error found : \(err)")
                }
            }
        }

    }
    
}





