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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    let subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 66/255, green: 85/255, blue: 99/255, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    let subTitleBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 232/255, green: 237/255, blue: 238/255, alpha: 1.0)
        view.layer.cornerRadius = 5
        return view
    }()
    
    func fillInfo(item: [String:String]) {
        self.title.text = item["name"]!
        self.subTitle.text = """
        owner: \(item["owner"]!)
        language: \(item["language"]!)
        created: \(item["created_at"]!)
        description: \(item["description"]!)
        """
    }

    fileprivate func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(subTitleBackground)
        contentView.addSubview(subTitle)
        
        let viewBorderSize: CGFloat = 16
        let backgroundBorderSize: CGFloat = 8
        
        let constraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewBorderSize),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewBorderSize),
            title.heightAnchor.constraint(equalToConstant: 25),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: viewBorderSize),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: viewBorderSize),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -viewBorderSize),
            subTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -viewBorderSize),
            
            subTitleBackground.topAnchor.constraint(equalTo: subTitle.topAnchor, constant: -backgroundBorderSize),
            subTitleBackground.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor, constant: -backgroundBorderSize),
            subTitleBackground.trailingAnchor.constraint(equalTo: subTitle.trailingAnchor, constant: backgroundBorderSize),
            subTitleBackground.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: backgroundBorderSize)
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
