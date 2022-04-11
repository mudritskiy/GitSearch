//
//  CellTile.swift
//  GitSearch
//
//  Created by Vldmr on 3/21/20.
//  Copyright © 2020 mudritskiy. All rights reserved.
//

import UIKit

class CellTile: UIView {

    init(_ bgColor: UIColor) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = bgColor
        
        self.layer.borderColor = UIColor.secondaryTint.cgColor
        
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowColor = #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1).cgColor
        self.layer.shadowOpacity = 0.3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
