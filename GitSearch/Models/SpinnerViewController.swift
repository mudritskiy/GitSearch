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
    
    func showHide(parent: UIViewController, _ show: Bool = true) {
        if show {
            parent.addChild(self)
            self.view.frame = parent.view.frame
            parent.view.addSubview(self.view)
            self.didMove(toParent: parent)
        } else {
            self.willMove(toParent: parent)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }

}
