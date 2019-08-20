//
//  CellView.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = #colorLiteral(red: 0.2588235294, green: 0.3333333333, blue: 0.3882352941, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let cellBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1).cgColor
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let cellLeftMark: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.5764705882, green: 0.2039215686, blue: 0.4117647059, alpha: 1)
        return view
    }()

    func roundCorners(viewToRound: UIView, cornerRadius: Double, cornerMask: CACornerMask) {
        viewToRound.layer.cornerRadius = CGFloat(cornerRadius)
        viewToRound.layer.maskedCorners = cornerMask
    }
    
    fileprivate func setupSubviews() {
        contentView.addSubview(cellLeftMark)
        contentView.addSubview(cellBackground)
        contentView.addSubview(title)
        contentView.addSubview(subTitle)

        let viewBorderSize: CGFloat = 10
        let backgroundBorderSize: CGFloat = 5
        
        roundCorners(viewToRound: cellBackground, cornerRadius: Double(backgroundBorderSize), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
        roundCorners(viewToRound: cellLeftMark, cornerRadius: Double(backgroundBorderSize), cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])

        let constraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: viewBorderSize*2),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewBorderSize),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewBorderSize),
            title.heightAnchor.constraint(equalToConstant: 18),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewBorderSize),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewBorderSize),
            subTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            cellBackground.topAnchor.constraint(equalTo: title.topAnchor, constant: -backgroundBorderSize),
            cellBackground.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor, constant: -backgroundBorderSize),
            cellBackground.trailingAnchor.constraint(equalTo: subTitle.trailingAnchor, constant: backgroundBorderSize),
            cellBackground.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: backgroundBorderSize),

            cellLeftMark.topAnchor.constraint(equalTo: title.topAnchor, constant: -backgroundBorderSize),
            cellLeftMark.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: -backgroundBorderSize),
            cellLeftMark.trailingAnchor.constraint(equalTo: cellBackground.leadingAnchor),
            cellLeftMark.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: backgroundBorderSize)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
