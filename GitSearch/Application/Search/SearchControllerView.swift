//
//  SearchControllerView.swift
//  GitSearch
//
//  Created by Vldmr on 9/29/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchControllerView: UIView, UITextFieldDelegate {
    
    var labelGit: PaddedLabel!
    var labelSearch: PaddedLabel!
    var labelAbout: PaddedLabel!
    var inputText: PaddedText!
    var actionButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func updateConstraints() {
        setupLayout()
        super.updateConstraints()
    }
}

private extension SearchControllerView {
    
    func setupUI() {
        self.backgroundColor = UIColor.mainTint
        let arrangedSubviews = setupSubviews()
        arrangedSubviews.forEach{self.addSubview($0)}
    }
    
    func setupSubviews() -> [UIView] {
        
        labelGit = PaddedLabel("GIT", font: .boldSystemFont(ofSize: 34), aligment: .right, backgroundColor: .mainTitle, cornerRadius: Double(Constants.commonHalfHeight), cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
        labelSearch = PaddedLabel("SEARCH", font: .boldSystemFont(ofSize: 34), backgroundColor: .secondaryTitle, cornerRadius: Double(Constants.commonHalfHeight), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
        
        labelAbout = PaddedLabel("Search information about any repository in github by keyword", font: .systemFont(ofSize: 13), color: .secondaryTitle)
        inputText = PaddedText("Enter keyword")
        
        actionButton = {
            let button = UIButton(type: UIButton.ButtonType.custom)
            button.backgroundColor = UIColor.mainTitle
            button.layer.cornerRadius = 20
            button.setTitle("Search", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            return button
        }()
        
        return [labelGit, labelSearch, labelAbout, inputText, actionButton]
        
    }
    
    func setupLayout() {
        
        guard let superview = superview else { return }
        anchor(to: superview.safeAreaLayoutGuide)
        
        let commonSize: CGSize = .init(width: 0, height: Constants.commonHeight)
        
        labelGit.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.3).isActive = true
        labelGit.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,
                        padding: .init(top: 50, left: Constants.commonHeight, bottom: 0, right: 0),
                        size: commonSize)
        
        labelSearch.anchor(top: labelGit.topAnchor, leading: labelGit.trailingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,
                           padding: .init(top: 0, left: 1, bottom: 0, right: -Constants.commonHeight),
                           size: commonSize)
        
        labelAbout.anchor(top: labelGit.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,
                          padding: .init(top: Constants.commonHeight, left: Constants.commonHeight, bottom: 0, right: -Constants.commonHeight))
        
        inputText.anchor(top: labelAbout.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor,
                         padding: .init(top: Constants.commonHeight, left: Constants.commonHeight, bottom: 0, right: -Constants.commonHeight),
                         size: commonSize)
        
        actionButton.anchor(top: inputText.bottomAnchor, leading: inputText.leadingAnchor, bottom: nil, trailing: inputText.trailingAnchor,
                            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
                            size: commonSize)
    }
    
}
