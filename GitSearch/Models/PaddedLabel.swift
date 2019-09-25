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
    
}
