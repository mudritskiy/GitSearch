//
//  SearchController.swift
//  GitSearch
//
//  Created by Vldmr on 7/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import Foundation
import UIKit

class SearchController: UIViewController, UITextFieldDelegate {
    
    private var labelGitWidth = 0
    
    let labelGit: PaddedLabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = PaddedLabel()
        label.text = NSLocalizedString("main.title-git", value: "GIT", comment: "Application title's left part. Don't need to be translate!")
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.layer.backgroundColor = UIColor.mainTitle.cgColor
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelSearch: PaddedLabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = PaddedLabel()
        label.text = NSLocalizedString("main.title-search", value: "SEARCH", comment: "Application title's right part. Don't need to be translate!")
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.layer.backgroundColor = UIColor.secondaryTitle.cgColor
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aboutLabel: UILabel = {
        let label = PaddedLabel()
        label.text = NSLocalizedString("main.about", value: "Search information about any repository in github by keyword", comment: "About this application")
        label.textAlignment = .left
        label.textColor = UIColor.secondaryTitle
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let inputText: PaddedText = {
        let textView = PaddedText()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.secondaryTint.cgColor
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1
        textView.backgroundColor = UIColor.white
        textView.keyboardType = .default
        textView.placeholder = NSLocalizedString("main.enter-keyword", value: "Enter keyword", comment: "Enter keyword for search repositories")
        textView.borderStyle = .none
        textView.clearButtonMode = .whileEditing
        return textView
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.mainTitle
        button.layer.cornerRadius = 20
        button.setTitle(NSLocalizedString("main.search-button-title", value: "Search", comment: "Start repositories search"), for: .normal)
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

        view.backgroundColor = UIColor.mainTint
        
        view.addSubview(labelGit)
        view.addSubview(labelSearch)
        view.addSubview(aboutLabel)
        view.addSubview(inputText)
        view.addSubview(actionButton)
        
        inputText.delegate = self
        
        let heightSize: CGFloat = 40
        roundCorners(viewToRound: labelGit, cornerRadius: Double(heightSize)/2, cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
        roundCorners(viewToRound: labelSearch, cornerRadius: Double(heightSize)/2, cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])


        let constraints = [
            labelGit.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            labelGit.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
            labelGit.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            labelGit.heightAnchor.constraint(equalToConstant: heightSize),
            
            labelSearch.topAnchor.constraint(equalTo: labelGit.topAnchor, constant: 0),
            labelSearch.leadingAnchor.constraint(equalTo: labelGit.trailingAnchor, constant: 1),
            labelSearch.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),
            labelSearch.heightAnchor.constraint(equalToConstant: heightSize),
            
            aboutLabel.topAnchor.constraint(equalTo: labelGit.bottomAnchor, constant: heightSize),
            aboutLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
            aboutLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),

            inputText.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: heightSize),
            inputText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
            inputText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),
            inputText.heightAnchor.constraint(equalToConstant: heightSize),
            
            actionButton.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20),
            actionButton.leadingAnchor.constraint(equalTo: inputText.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: inputText.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: heightSize)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
            postAlert(title: SearchUserAlerts.noKeyword.title, message: SearchUserAlerts.noKeyword.message)
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
                    if gitRep?.total_count == 0 {
                        self.postAlert(title: SearchUserAlerts.noDataFound.title, message: SearchUserAlerts.noDataFound.message)
                    } else {
                        let newVC = SearchResultViewController(data: gitRep!)
                        self.navigationController?.pushViewController(newVC, animated: true)
                    }
                case .failure(let err):
                    self.postAlert(title: SearchUserAlerts.errorFound.title, message: err.localizedDescription)
                }
            }
        }

    }
    
}
