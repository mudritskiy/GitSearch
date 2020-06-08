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
    
    var childView: SearchControllerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainTint

        childView = SearchControllerView(frame: self.view.bounds)
        self.view.addSubview(childView)
        childView.setNeedsUpdateConstraints()
        childView.actionButton.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        childView.inputText.delegate = self as UITextFieldDelegate

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        childView.setNeedsUpdateConstraints()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        childView.setNeedsUpdateConstraints()
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
    
    @objc func buttonAction(_ sender: UIButton!) {
        
        guard let keyWords = childView.inputText.text else { return }
        
        if keyWords.isEmpty {
            postAlert(title: SearchUserAlerts.noKeyword.title, message: SearchUserAlerts.noKeyword.message)
            return
        }
        
        let spinner = SpinnerViewController(for: self)
        spinner.toggle()
        
        let keys = keyWords.components(separatedBy: " ")
        let keysSequence = keys.joined(separator: "+")
        
        SearchServices.shared.getRepositories(keysSequence: keysSequence) { res in
            DispatchQueue.main.async {
                spinner.toggle()
                switch res {
                case .success(let gitRep):
                    if gitRep.total_count == 0 {
                        self.postAlert(title: SearchUserAlerts.noDataFound.title, message: SearchUserAlerts.noDataFound.message)
                    } else {
                        let newVC = SearchResultViewController(data: gitRep)
                        self.navigationController?.pushViewController(newVC, animated: true)
                    }
                case .failure(let err):
                    self.postAlert(title: SearchUserAlerts.errorFound.title, message: err.localizedDescription)
                }
            }
        }

    }
    
}
