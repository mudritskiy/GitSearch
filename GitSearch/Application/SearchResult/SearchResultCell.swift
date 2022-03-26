//
//  CellView.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    private let _title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "Avenir-Black", size: 20)
        label.textColor = UIColor.black
        return label
    }()

    private let _author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AvenirNext-UltraLight", size: 12)
        label.textColor = UIColor.black
        return label
    }()

    private let _subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.init(name: "AvenirNext-Regular", size: 14)
        label.textColor = #colorLiteral(red: 0.2588235294, green: 0.3333333333, blue: 0.3882352941, alpha: 1)
        label.numberOfLines = 0
        return label
    }()

    private let _cellBackground: UIView = {
        let view = CellTile(.white)
        view.roundCorners(cornerRadius: Double(30), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
        return view
    }()

    private let _cellLeftMark: UIView = {
        let view = CellTile(.mainTitle)
        view.roundCorners(cornerRadius: 2, cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
        return view
    }()
    
    private var _lastCell: Bool = false

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
        _setupUI()
        _setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fillInfo(for item: SearchItem, isLast: Bool) {
        _lastCell = isLast
        _title.text = item.name
        _author.text = "by \(item.owner?.login ?? "")"
        _subTitle.text = item.description
    }

    private func _setupUI() {
        let arrangedSubviews = [_cellBackground, _cellLeftMark, _title, _author, _subTitle]
        arrangedSubviews.forEach{ contentView.addSubview($0) }
    }

    private func _setupLayout() {

        let borderSize: CGFloat = 10

        _title.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: borderSize*2, left: borderSize*3, bottom: 0, right: -borderSize*3),
            size: .init(width: 0, height: _title.font.pointSize + borderSize)
        )

        _author.anchor(
            top: _title.bottomAnchor,
            leading: _title.leadingAnchor,
            trailing: _title.trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: _author.font.pointSize + 0)
        )

        _subTitle.anchor(
            top: _author.bottomAnchor,
            leading: _title.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: _title.trailingAnchor,
            padding: .init(top: borderSize*2, left: 0, bottom: -borderSize*2, right: 0)
        )

        _cellBackground.anchor(
            top: _title.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: -borderSize, left: borderSize, bottom: 0, right: 0)
        )

        _cellLeftMark.anchor(
            top: _cellBackground.topAnchor,
            leading: _cellBackground.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: _cellBackground.leadingAnchor,
            padding: .init(top: 0, left: -borderSize, bottom: 0, right: 0)
        )
    }
}
