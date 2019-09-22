//
//  RepoInfoDescriptionCell.swift
//  GitSearch
//
//  Created by Vldmr on 8/18/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoDescriptionCell: UITableViewCell {
    
    let propertyValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    let cellBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.7882352941, green: 0.7529411765, blue: 0.737254902, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    func setupSubviews() {
        contentView.addSubview(cellBackground)
        contentView.addSubview(propertyValue)
        
        let borderSize: CGFloat = 25
        let backgroundSize: CGFloat = 10
        
        let constraints = [
            propertyValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderSize),
            propertyValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize),
            propertyValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize),
            propertyValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -backgroundSize),
            
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderSize-backgroundSize),
            cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize-backgroundSize),
            cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize+backgroundSize),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
