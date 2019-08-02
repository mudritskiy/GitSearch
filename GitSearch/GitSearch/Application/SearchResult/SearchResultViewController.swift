//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchResultViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var gitRep: SearchInfo?
    var props = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(SearchResultCellView.self, forCellWithReuseIdentifier: "cellId")
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchResultCellView
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
    
    func cellProcessing(index: Int, cellInstance: SearchResultCellView? = nil) {
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
            let newVC = RepoInfoViewController()
            newVC.props = props
            props.forEach { prop in newVC.repInfo[prop] = item[prop] }
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
}



