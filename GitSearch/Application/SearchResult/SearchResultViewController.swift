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
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Search results"

        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(SearchResultCell.self, forCellWithReuseIdentifier: "cellId")
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.size.width-32, height: 120)
        collectionView?.collectionViewLayout = layout
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = gitRep?.items?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! SearchResultCell
        if let item = getItemAtIndex(index: indexPath.row) {
            cell.fillInfo(item: item)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = getItemAtIndex(index: indexPath.row) {
            let newVC = RepoInfoViewController()
            newVC.props = props
            props.forEach { prop in
                newVC.repInfo[prop] = item[prop]
            }
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    func getItemAtIndex(index: Int) -> Dictionary<String, String>! {
        guard let gitItems = self.gitRep?.items else {
            return nil
        }
        return gitItems[index].ToArray(props: &props)
    }
}



