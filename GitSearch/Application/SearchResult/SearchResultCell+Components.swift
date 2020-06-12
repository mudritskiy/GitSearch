//
//  SearchResultUIElements.swift
//  GitSearch
//
//  Created by Vldmr on 6/12/20.
//  Copyright © 2020 mudritskiy. All rights reserved.
//

import UIKit

extension SearchResultCell {
    
    func setupSubviews() -> [UIView] {
        
        title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.init(name: "Avenir-Black", size: 20)
        title.textColor = UIColor.black
        
        author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.init(name: "AvenirNext-UltraLight", size: 12)
        author.textColor = UIColor.black
        
        subTitle = UILabel()
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.font = UIFont.init(name: "AvenirNext-Regular", size: 14)
        subTitle.textColor = #colorLiteral(red: 0.2588235294, green: 0.3333333333, blue: 0.3882352941, alpha: 1)
        subTitle.numberOfLines = 0
        
        cellBackground = CellTile(.white)
        cellBackground.roundCorners(cornerRadius: Double(30), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
        
        cellLeftMark = CellTile(.mainTitle)
        cellLeftMark.roundCorners(cornerRadius: 2, cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
        
        return [cellBackground, cellLeftMark, title, author, subTitle]
    }
}
