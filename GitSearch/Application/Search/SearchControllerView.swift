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
    private let heightSize: CGFloat = 40
    
    let labelGit: PaddedLabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = PaddedLabel()
        label.text = "GIT"
        label.textAlignment = .right
        label.textColor = UIColor.white
        label.layer.backgroundColor = UIColor.mainTitle.cgColor
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let labelSearch: PaddedLabel = {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let label = PaddedLabel()
        label.text = "SEARCH"
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.layer.backgroundColor = UIColor.secondaryTitle.cgColor
        label.font = lableFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let aboutLabel: UILabel = {
        let label = PaddedLabel()
        label.text = "Search information about any repository in github by keyword"
        label.textAlignment = .left
        label.textColor = UIColor.secondaryTitle
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let inputText: PaddedText = {
        let textView = PaddedText()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.secondaryTint.cgColor
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1
        textView.backgroundColor = UIColor.white
        textView.keyboardType = .default
        textView.placeholder = "Enter keyword"
        textView.borderStyle = .none
        textView.clearButtonMode = .whileEditing
        return textView
    }()

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
        
        self.addSubview(labelGit)
        self.addSubview(labelSearch)
        self.addSubview(aboutLabel)
        self.addSubview(inputText)
        self.addSubview(actionButton)
        
        self.inputText.delegate = self as UITextFieldDelegate
        self.backgroundColor = UIColor.mainTint

        roundCorners(viewToRound: labelGit, cornerRadius: Double(heightSize)/2, cornerMask: [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMinXMaxYCorner])
        roundCorners(viewToRound: labelSearch, cornerRadius: Double(heightSize)/2, cornerMask: [CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMaxXMaxYCorner])
    }
    
    func setupLayout() {
        
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
                
                aboutLabel.topAnchor.constraint(equalTo: labelGit.bottomAnchor, constant: heightSize),
                aboutLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: heightSize),
                aboutLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -heightSize),
                
                inputText.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: heightSize),
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
