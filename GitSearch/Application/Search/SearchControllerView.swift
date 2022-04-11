//
//  SearchControllerView.swift
//  GitSearch
//
//  Created by Vldmr on 9/29/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

protocol SearchControllerViewDelegate: AnyObject {
    func processInputKeywords(keysSequence: String?)
}

final class SearchControllerView: UIView, UITextFieldDelegate {

    weak var delegate: SearchControllerViewDelegate?
    
    private let _labelGit = PaddedLabel(
        StringsLocalized.MainScreen.labelGit,
        font: .boldSystemFont(ofSize: 34),
        aligment: .right,
        backgroundColor: .mainTitle,
        cornerRadius: Double(Constants.Size.commonHalfHeight),
        cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner]
    )

    private let _labelSearch = PaddedLabel(
        StringsLocalized.MainScreen.labelSearch,
        font: .boldSystemFont(ofSize: 34),
        backgroundColor: .secondaryTitle,
        cornerRadius: Double(Constants.Size.commonHalfHeight),
        cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner]
    )

    private let _labelAbout = PaddedLabel(
        StringsLocalized.MainScreen.labelAbout,
        font: .systemFont(ofSize: 13),
        color: .secondaryTitle
    )

    private let _inputText = PaddedText(StringsLocalized.MainScreen.inputText)

    private lazy var _actionButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.mainTitle
        button.layer.cornerRadius = 20
        button.setTitle(StringsLocalized.MainScreen.actionButtonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _setupUI()
    }

    // MARK: - Views AutoLayout
    override func updateConstraints() {
        _setupLayout()
        super.updateConstraints()
    }

    private func _setupUI() {
        let arrangedSubviews = [_labelGit, _labelSearch, _labelAbout, _inputText, _actionButton]
        arrangedSubviews.forEach { self.addSubview($0) }
        _actionButton.addTarget(self, action: #selector(_buttonAction(_:)), for: .touchUpInside)
        _inputText.delegate = self as UITextFieldDelegate

    }
    
    private func _setupLayout() {
        guard let superview = superview else { return }
        self.anchor(to: superview.safeAreaLayoutGuide)
        
        let commonSize: CGSize = .init(width: 0, height: Constants.Size.commonHeight)

        _labelGit.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.3).isActive = true
        _labelGit.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            padding: .init(
                top: 50,
                left: Constants.Size.commonHeight,
                bottom: 0,
                right: 0
            ),
            size: commonSize
        )
        
        _labelSearch.anchor(
            top: _labelGit.topAnchor,
            leading: _labelGit.trailingAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .init(
                top: 0,
                left: 1,
                bottom: 0,
                right: -Constants.Size.commonHeight
            ),
            size: commonSize
        )
        
        _labelAbout.anchor(
            top: _labelGit.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .init(
                top: Constants.Size.commonHeight,
                left: Constants.Size.commonHeight,
                bottom: 0,
                right: -Constants.Size.commonHeight
            )
        )
        
        _inputText.anchor(
            top: _labelAbout.bottomAnchor,
            leading: safeAreaLayoutGuide.leadingAnchor,
            trailing: safeAreaLayoutGuide.trailingAnchor,
            padding: .init(
                top: Constants.Size.commonHeight,
                left: Constants.Size.commonHeight,
                bottom: 0,
                right: -Constants.Size.commonHeight
            ),
            size: commonSize
        )
        
        _actionButton.anchor(
            top: _inputText.bottomAnchor,
            leading: _inputText.leadingAnchor,
            trailing: _inputText.trailingAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
            size: commonSize
        )
    }

    @objc
    private func _buttonAction(_ sender: UIButton!) {
        let keysSequence = _keysSequence(from: _inputText.text)
        delegate?.processInputKeywords(keysSequence: keysSequence)
    }

    private func _keysSequence(from keyWords: String?) -> String? {
        guard let keyWords = keyWords, !keyWords.isEmpty else { return nil }
        let keys = keyWords.components(separatedBy: " ")
        let keysSequence = keys.joined(separator: "+")
        return keysSequence
    }
}
