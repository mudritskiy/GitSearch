//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var gitRep: SearchInfo?
    var props = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CellClass.self, forCellWithReuseIdentifier: "cellId")
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.size.width-32, height: 120)
        collectionView?.collectionViewLayout = layout
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search results"
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = gitRep?.items?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CellClass
        cellProcessing(index: indexPath.row, cellInstance: cell)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellProcessing(index: indexPath.row)
    }
    
    func strucToArray(resource: SearchItem) -> Dictionary<String, String> {
        var result = [String: String]()
        var childValue: String?
        let propsFilled = props.count != 0
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        
        let mirror = Mirror(reflecting: resource)
        for child in mirror.children  {
            let childKey = child.label!
            if childKey != "owner" {
                if let value = child.value as? Int {
                    childValue = String(value)
                }
                else if let value = child.value as? Double {
                    childValue = String(value)
                }
                else if let value = child.value as? String {
                    if let date: Date = dateFormatterGet.date(from: value) {
                        childValue = dateFormatter.string(from: date)
                    } else {
                        childValue = value
                    }
                }
                else {childValue = ""}
            } else {
                childValue = (child.value as! Owners).login!
            }
            if !propsFilled {
                props.append(childKey)
            }
            result[childKey] = childValue
        }
        return result
    }
    
    func cellProcessing(index: Int, cellInstance: CellClass? = nil) {
        guard let gitItems = self.gitRep?.items else { return }
        let item = strucToArray(resource: gitItems[index]) // why item's value are optional when type inside is non oprional String:String
        if let cell = cellInstance {
            // dwar information
            cell.title.text = gitItems[index].name!
            cell.subTitle.text = """
            owner: \(item["owner"]!)
            language: \(item["language"]!)
            created: \(item["created_at"]!)
            description: \(item["description"]!)
            """
        } else {
            // open cell
            let newVC = CellDetailTableView()
            newVC.props = props
            props.forEach { prop in newVC.repInfo[prop] = item[prop] }
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
}

class CellClass: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
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
    
    fileprivate func setupSubviews() {
        contentView.addSubview(title)
        contentView.addSubview(subTitleBackground)
        contentView.addSubview(subTitle)
        
        let constraints = [
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            //title.heightAnchor.constraint(equalToConstant: 16),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            subTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subTitleBackground.topAnchor.constraint(equalTo: subTitle.topAnchor, constant: -8),
            subTitleBackground.leadingAnchor.constraint(equalTo: subTitle.leadingAnchor, constant: -8),
            subTitleBackground.trailingAnchor.constraint(equalTo: subTitle.trailingAnchor, constant: 8),
            subTitleBackground.bottomAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
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

