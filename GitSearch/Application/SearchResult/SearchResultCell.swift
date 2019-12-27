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
    private let borderSize: CGFloat = 10

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
        self.subTitle.text = """
        \(item.description ?? "")
        """
    }
}

private extension SearchResultCell {
    
    func setupUI() {
        let arrangedSubviews = setupSubviews()
        arrangedSubviews.forEach{contentView.addSubview($0)}
        contentView.setNeedsUpdateConstraints()
    }
    
    func setupSubviews() -> [UIView] {
        title = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.init(name: "Avenir-Black", size: 20)
            label.textColor = UIColor.black
            return label
        }()
        
        author = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.init(name: "AvenirNext-UltraLight", size: 12)
            label.textColor = UIColor.black
            return label
        }()
        
        subTitle = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.init(name: "AvenirNext-Regular", size: 14)
            label.textColor = #colorLiteral(red: 0.2588235294, green: 0.3333333333, blue: 0.3882352941, alpha: 1)
            label.numberOfLines = 0
            return label
        }()
        
        cellBackground = {
            let view = CellTile(.white)
            view.roundCorners(cornerRadius: Double(borderSize*3), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
            return view
        }()
        
        cellLeftMark = {
            let view = CellTile(.mainTitle)
            view.roundCorners(cornerRadius: 2, cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
            return view
        }()
        
        return [cellBackground, cellLeftMark, title, author, subTitle]
    }
    
    func setupLayout() {

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
