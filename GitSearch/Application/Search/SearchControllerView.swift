//
//  SearchControllerView.swift
//  GitSearch
//
//  Created by Vldmr on 9/29/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchControllerView: UIView, UITextFieldDelegate {
    
    private var constraintsList = [NSLayoutConstraint]()
    private var shouldSetConstraints = true
    private let heightSize: CGFloat = 40
    
    let labelGit = PaddedLabel("GIT", font: .boldSystemFont(ofSize: 34), aligment: .right, backgroundColor: .mainTitle, cornerRadius: Double(Constants.commonHalfHeight), cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
    let labelSearch = PaddedLabel("SEARCH", font: .boldSystemFont(ofSize: 34), backgroundColor: .secondaryTitle, cornerRadius: Double(Constants.commonHalfHeight), cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
    
    let labelAbout = PaddedLabel("Search information about any repository in github by keyword", font: .systemFont(ofSize: 13), color: .secondaryTitle)
    let inputText = PaddedText("Enter keyword")

    let actionButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.mainTitle
        button.layer.cornerRadius = 20
        button.setTitle("Search", for: .normal)
        button.addTarget(self, action: #selector(SearchController.buttonAction(_:)), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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
    
    // must be global `cause used in several places
    func roundCorners(viewToRound: UIView, cornerRadius: Double, cornerMask: CACornerMask) {
        viewToRound.layer.cornerRadius = CGFloat(cornerRadius)
        viewToRound.layer.maskedCorners = cornerMask
    }

    func setupUI() {
        let arrangedSubviews = [labelGit, labelSearch, labelAbout, inputText, actionButton]
        arrangedSubviews.forEach{self.addSubview($0)}
        
        self.inputText.delegate = self as UITextFieldDelegate
        self.backgroundColor = UIColor.mainTint
    }
    
    func setupLayout() {
        
//        if shouldSetConstraints {
//            shouldSetConstraints = false
//        labelGit.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
//        labelGit.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,
//                        padding: .init(top: 50, left: Constants.commonHeight, bottom: 0, right: 0),
//                        size: .init(width: 0, height: Constants.commonHeight))
//
//        labelSearch.anchor(top: labelGit.topAnchor, leading: labelGit.trailingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor,
//                           padding: .init(top: 0, left: 1, bottom: 0, right: -Constants.commonHeight),
//                           size: .init(width: 0, height: Constants.commonHeight))
//
//        labelAbout.anchor(top: labelGit.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor,
//                          padding: .init(top: Constants.commonHeight, left: Constants.commonHeight, bottom: 0, right: -Constants.commonHeight))
//
//        inputText.anchor(top: labelAbout.bottomAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: self.safeAreaLayoutGuide.trailingAnchor,
//                         padding: .init(top: Constants.commonHeight, left: Constants.commonHeight, bottom: 0, right: -Constants.commonHeight),
//                         size: .init(width: 0, height: Constants.commonHeight))
//
//        actionButton.anchor(top: inputText.bottomAnchor, leading: inputText.leadingAnchor, bottom: nil, trailing: inputText.trailingAnchor,
//                            padding: .init(top: 20, left: 0, bottom: 0, right: 0),
//                            size: .init(width: 0, height: Constants.commonHeight))
//
//        }
        if constraintsList.count == 0 {
            
            constraintsList = [
                labelGit.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
                labelGit.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
                labelGit.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
                labelGit.heightAnchor.constraint(equalToConstant: heightSize),
                
                labelSearch.topAnchor.constraint(equalTo: labelGit.topAnchor, constant: 0),
                labelSearch.leadingAnchor.constraint(equalTo: labelGit.trailingAnchor, constant: 1),
                labelSearch.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),
                labelSearch.heightAnchor.constraint(equalToConstant: heightSize),
                
                labelAbout.topAnchor.constraint(equalTo: labelGit.bottomAnchor, constant: heightSize),
                labelAbout.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
                labelAbout.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),
                
                inputText.topAnchor.constraint(equalTo: labelAbout.bottomAnchor, constant: heightSize),
                inputText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
                inputText.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),
                inputText.heightAnchor.constraint(equalToConstant: heightSize),
                
                actionButton.topAnchor.constraint(equalTo: inputText.bottomAnchor, constant: 20),
                actionButton.leadingAnchor.constraint(equalTo: inputText.leadingAnchor),
                actionButton.trailingAnchor.constraint(equalTo: inputText.trailingAnchor),
                actionButton.heightAnchor.constraint(equalToConstant: heightSize)
            ]
            
            NSLayoutConstraint.activate(constraintsList)
        }
    }
}
