//
//  SpinnerViewController.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    var owner: UIViewController
    var stateOn: Bool = false
    
    init(for parentView: UIViewController) {
        owner = parentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

extension SpinnerViewController {
    
    func toggle() {

        func add() {
            owner.addChild(self)
            self.view.frame = owner.view.frame
            owner.view.addSubview(self.view)
            self.didMove(toParent: owner)
        }
        
        func remove() {
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }

        let switcher = stateOn ? remove : add
        switcher()
        stateOn = !stateOn
    }
    
}

