//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchController: UIViewController, UITextFieldDelegate {
    
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
//        label.backgroundColor = UIColor(red:0.41, green:0.56, blue:0.81, alpha:1.0) // blue
        label.backgroundColor = UIColor(red: 0/255, green: 159/255, blue: 214/255, alpha: 1.0)
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let inputText: PadeedText = {
        let textView = PadeedText()
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
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1.0)
        button.layer.cornerRadius = 5
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(SearchController.buttonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate func setupSubviews() {

        view.addSubview(labelGit)
        view.addSubview(labelSearch)
        view.addSubview(inputText)
        view.addSubview(actionButton)
        
        inputText.delegate = self
        inputText.becomeFirstResponder()
        
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
            inputText.widthAnchor.constraint(equalToConstant: CGFloat(300)),
            inputText.heightAnchor.constraint(equalToConstant: CGFloat(50)),
            
            actionButton.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: CGFloat(300)),
            actionButton.heightAnchor.constraint(equalToConstant: CGFloat(50))
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupSubviews()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
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
    
    func showHideSpinner(spinner child: SpinnerVC, _ show: Bool = true) {
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
        
        guard let keyWord = inputText.text else { return }
        
        if keyWord.isEmpty {
            postAlert(title: "No keyword", message: "Please, enter some keyword")
            return
        }
        
        let child = SpinnerVC()
        showHideSpinner(spinner: child)

        let urlQuery = "https://api.github.com/search/repositories?q="+keyWord+"&sort=stars&order=desc"
        fetchRepositoriesHeader(from: urlQuery) { gitRep in
            DispatchQueue.main.async {
                self.showHideSpinner(spinner: child, false)
                if gitRep.total_count == 0 {
                    self.postAlert(title: "No data found", message: "Please, try another  keyword")
                } else {
                    let newVC = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
                    newVC.gitRep = gitRep
                    self.navigationController?.pushViewController(newVC, animated: true)
                }
            }
        }

    }
    
}

class PadeedText: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}

class SpinnerVC: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
