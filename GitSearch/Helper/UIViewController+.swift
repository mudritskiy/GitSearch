//
//  UIViewController+.swift
//  GitSearch
//
//  Created by Vldmr on 6/15/20.
//  Copyright © 2020 mudritskiy. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var spinnerTag: Int { return 999 }
    
    func addSpinner(
        style: UIActivityIndicatorView.Style = .medium,
        location: CGPoint? = nil
    ) {
        
        let spinner = UIActivityIndicatorView(style: style)
        spinner.tag = self.spinnerTag
        spinner.center = location ?? self.view.center
        spinner.hidesWhenStopped = true
        
        spinner.startAnimating()
        self.view.addSubview(spinner)
        
    }
    
    func removeSpinner() {
        if let spinner = self.view.subviews.filter( { $0.tag == self.spinnerTag } ).first as? UIActivityIndicatorView {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
        }
    }
}

