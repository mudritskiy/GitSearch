//
//  SearchResultCell+Constraints.swift
//  GitSearch
//
//  Created by Vldmr on 6/12/20.
//  Copyright © 2020 mudritskiy. All rights reserved.
//

import UIKit

extension SearchResultCell {
    
    func setupLayout() {
        
        let borderSize: CGFloat = 10
        
        title.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor,
                     padding: .init(top: borderSize*2, left: borderSize*3, bottom: 0, right: -borderSize*3),
                     size: .init(width: 0, height: title.font.pointSize + borderSize))
        
        author.anchor(top: title.bottomAnchor, leading: title.leadingAnchor, bottom: nil, trailing: title.trailingAnchor,
                      padding: .init(top: 0, left: 0, bottom: 0, right: 0),
                      size: .init(width: 0, height: author.font.pointSize + 0))
        
        subTitle.anchor(top: author.bottomAnchor, leading: title.leadingAnchor, bottom: contentView.bottomAnchor, trailing: title.trailingAnchor,
                        padding: .init(top: borderSize*2, left: 0, bottom: -borderSize*2, right: 0))
        
        cellBackground.anchor(top: title.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor,
                              padding: .init(top: -borderSize, left: borderSize, bottom: 0, right: 0))
        cellLeftMark.anchor(top: cellBackground.topAnchor, leading: cellBackground.leadingAnchor, bottom: contentView.bottomAnchor, trailing: cellBackground.leadingAnchor,
                            padding: .init(top: 0, left: -borderSize, bottom: 0, right: 0))
    }
}
