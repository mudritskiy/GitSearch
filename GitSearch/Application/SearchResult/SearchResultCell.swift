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
        label.textColor = UIColor(red: 66/255, green: 85/255, blue: 99/255, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    let subTitleBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0).cgColor
        view.layer.shadowOpacity = 0.5
        return view
    }()
    
    let subTitleBackground2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 147/255, green: 52/255, blue: 105/255, alpha: 1.0)
        return view
    }()

    func roundCorners(viewToRound: UIView, cornerRadius: Double, cornerMask: CACornerMask) {
        viewToRound.layer.cornerRadius = CGFloat(cornerRadius)
        viewToRound.layer.maskedCorners = cornerMask
    }
    
    fileprivate func setupSubviews() {
        contentView.addSubview(subTitleBackground2)
        contentView.addSubview(subTitleBackground)
        contentView.addSubview(title)
        contentView.addSubview(subTitle)

        let viewBorderSize: CGFloat = 10
        let backgroundBorderSize: CGFloat = 5
        
        roundCorners(viewToRound: subTitleBackground, cornerRadius: Double(backgroundBorderSize), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
        roundCorners(viewToRound: subTitleBackground2, cornerRadius: Double(backgroundBorderSize), cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])

        let constraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: viewBorderSize*2),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewBorderSize),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewBorderSize),
            title.heightAnchor.constraint(equalToConstant: 18),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewBorderSize),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewBorderSize),
            subTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            subTitleBackground.topAnchor.constraint(equalTo: title.topAnchor, constant: -backgroundBorderSize),
            subTitleBackground.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor, constant: -backgroundBorderSize),
            subTitleBackground.trailingAnchor.constraint(equalTo: subTitle.trailingAnchor, constant: backgroundBorderSize),
            subTitleBackground.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: backgroundBorderSize),

            subTitleBackground2.topAnchor.constraint(equalTo: title.topAnchor, constant: -backgroundBorderSize),
            subTitleBackground2.leadingAnchor.constraint(equalTo: subTitleBackground.leadingAnchor, constant: -backgroundBorderSize),
            subTitleBackground2.trailingAnchor.constraint(equalTo: subTitleBackground.leadingAnchor),
            subTitleBackground2.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: backgroundBorderSize)
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
