//
//  PaddedLabel.swift
//  GitSearch
//
//  Created by Vldmr on 8/18/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class PaddedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
    
    init(_ text: String, font: UIFont, aligment: NSTextAlignment = NSTextAlignment.left , color: UIColor = UIColor.white , backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        
        if let backgroundColor = backgroundColor {
            self.layer.backgroundColor = backgroundColor.cgColor
        }
        
        self.text = text
        self.textAlignment = aligment
        self.textColor = color
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
