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
    
    private let _cellBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.7882352941, green: 0.7529411765, blue: 0.737254902, alpha: 1)
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _setupSubviews() {
        contentView.addSubview(_cellBackground)
        contentView.addSubview(propertyValue)

        let borderSize: CGFloat = 25
        let backgroundSize: CGFloat = 10

        NSLayoutConstraint.activate([
            propertyValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderSize),
            propertyValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize),
            propertyValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize),
            propertyValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -backgroundSize),

            _cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderSize-backgroundSize),
            _cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize-backgroundSize),
            _cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize+backgroundSize),
            _cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
