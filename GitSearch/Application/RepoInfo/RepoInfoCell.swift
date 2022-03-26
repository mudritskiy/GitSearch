//
//  RepoInfoCellView.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoCell: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        return label
    }()
    
    let propertyValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
        }()
    
    private let _separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
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
        contentView.addSubview(title)
        contentView.addSubview(propertyValue)
        contentView.addSubview(_separator)

        let borderSize: CGFloat = 25
        let borderSizeShift: CGFloat = 5
        let separatorHeight: CGFloat = 1

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize + borderSizeShift),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize*2),

            propertyValue.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            propertyValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize),
            propertyValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize*2),
            propertyValue.bottomAnchor.constraint(equalTo: _separator.topAnchor),

            _separator.heightAnchor.constraint(equalToConstant: separatorHeight),
            _separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize - borderSizeShift),
            _separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize*2),
            _separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
        ])
    }
 }
