//
//  UIView+Misc.swift
//  GitSearch
//
//  Created by Vldmr on 10/19/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

extension UIView {

    func roundCorners(cornerRadius: Double, cornerMask: CACornerMask) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.layer.maskedCorners = cornerMask
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = UIEdgeInsets.zero,
                size: CGSize = CGSize.zero) {
        
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
   
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    func anchor(to layoutGuide: UILayoutGuide) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            ])
    }

}
