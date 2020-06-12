//
//  CellView.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    var title: UILabel!
    var author: UILabel!
    var subTitle: UILabel!
    var cellBackground: UIView!
    var cellLeftMark: UIView!
    
    private var lastCell: Bool = false

    override func updateConstraints() {
        setupLayout()
        super.updateConstraints()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchResultCell {

    func fillInfo(for item: SearchItem, isLast: Bool) {
        self.lastCell = isLast
        self.title.text = item.name
        self.author.text = "by \(item.owner?.login ?? "")"
        self.subTitle.text = item.description
    }

    private func setupUI() {
        let arrangedSubviews = setupSubviews()
        arrangedSubviews.forEach{ contentView.addSubview($0) }
        contentView.setNeedsUpdateConstraints()
    }
}
