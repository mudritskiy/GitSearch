//
//  RepoInfoDescriptionCell.swift
//  GitSearch
//
//  Created by Vldmr on 8/18/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class RepoInfoDescriptionCell: UITableViewCell {
    
    private let _propertyValue: UILabel = {
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

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        _setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Views Configuration
    private func _setupSubviews() {
        contentView.addSubview(_cellBackground)
        contentView.addSubview(_propertyValue)

        let borderSize: CGFloat = 25
        let backgroundSize: CGFloat = 10

        NSLayoutConstraint.activate([
            _propertyValue.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderSize),
            _propertyValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize),
            _propertyValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize),
            _propertyValue.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -backgroundSize),

            _cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: borderSize-backgroundSize),
            _cellBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: borderSize-backgroundSize),
            _cellBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -borderSize+backgroundSize),
            _cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - Setup
    func setup(with item: RepoField) {
        _propertyValue.text = item.value
    }
}
