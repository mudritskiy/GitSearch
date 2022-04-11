//
//  CellView.swift
//  GitSearch
//
//  Created by Vldmr on 8/3/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

final class SearchResultCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout {

    private let _subtitleContentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()

    private let _title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.title
        label.textColor = UIColor.black
        return label
    }()

    private let _author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.regular
        label.textColor = UIColor.black
        return label
    }()

    private let _subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.subtitle
        label.textColor = #colorLiteral(red: 0.2588235294, green: 0.3333333333, blue: 0.3882352941, alpha: 1)
        label.numberOfLines = 0
        return label
    }()

    private let _cellBackground: UIView = {
        let view = CellTile(.white)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners(
            cornerRadius: Double(30),
            cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner]
        )
        return view
    }()

    private let _cellLeftMark: UIView = {
        let view = CellTile(.mainTitle)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCorners(
            cornerRadius: 2,
            cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner]
        )
        return view
    }()

    private let _starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.systemYellow
        imageView.image = UIImage(systemName: "star.fill")
        return imageView
    }()

    private let _starLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.regular
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()

    private let _pushedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Font.regular
        label.textColor = UIColor.black
        label.textAlignment = .justified
        return label
    }()

    // MARK: - Preferred Size
    override func preferredLayoutAttributesFitting(
        _ layoutAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }

    // MARK: - Reuse
    override func prepareForReuse() {
        _title.text = ""
        _author.text = ""
        _subTitle.text = ""
        _starLabel.text = ""
        _pushedLabel.text = ""
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
        _setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    public func setup(with item: SearchItem) {
        _title.text = item.name
        _author.text = "by \(item.owner?.login ?? "")"
        _subTitle.text = item.description
        _starLabel.text = String(item.stars)
        _pushedLabel.text = StringsLocalized.RepoInfo.pushed + " "
            + DateFormatter.MonthDayYear.string(from: item.pushed.value)
    }

    // MARK: - View Configuration
    private func _setupUI() {
        let arrangedSubviews = [
            _cellBackground,
            _cellLeftMark,
            _title,
            _subtitleContentStack,
            _subTitle,
            _pushedLabel,
        ]
        arrangedSubviews.forEach{ contentView.addSubview($0) }

        _subtitleContentStack.addArrangedSubview(_author)
        _subtitleContentStack.addArrangedSubview(_starImage)
        _subtitleContentStack.addArrangedSubview(_starLabel)
    }

    // MARK: - AutoLayout Configuration
    private func _setupLayout() {
        let borderSize: CGFloat = 10

        _title.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(top: borderSize*2, left: borderSize*3, bottom: 0, right: -borderSize*3),
            size: .init(width: 0, height: _title.font.pointSize + borderSize)
        )

        _subtitleContentStack.anchor(
            top: _title.bottomAnchor,
            leading: _title.leadingAnchor,
            size: .init(width: 0, height: _author.font.pointSize + borderSize)
        )

        _subTitle.anchor(
            top: _subtitleContentStack.bottomAnchor,
            leading: _title.leadingAnchor,
            trailing: _title.trailingAnchor,
            padding: .init(top: borderSize, left: 0, bottom: -borderSize*2, right: 0)
        )

        _pushedLabel.anchor(
            top: _subTitle.bottomAnchor,
            leading: _title.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: _title.trailingAnchor,
            padding: .init(top: borderSize, left: 0, bottom: -borderSize, right: 0),
            size: .init(width: 0, height: _pushedLabel.font.pointSize + borderSize)
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
