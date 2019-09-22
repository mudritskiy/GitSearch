//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class SearchResultViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var gitRep: SearchInfo
    private var props = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Search results"

        collectionView?.backgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        collectionView?.register(SearchResultCell.self, forCellWithReuseIdentifier: "cellId")
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.size.width-32, height: 120)
        collectionView?.collectionViewLayout = layout
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gitRep.items?.count ?? 0
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
            let newVC = RepoInfoViewController(properties: props, item: item)
            navigationController?.pushViewController(newVC, animated: true)
        }
    }
    
    func getItemAtIndex(index: Int) -> Dictionary<String, String>! {
        guard let gitItems = self.gitRep.items else {
            return nil
        }
        return gitItems[index].ToArray(props: &props)
    }
    
    init(data: SearchInfo) {
        let layout = UICollectionViewFlowLayout()
        gitRep = data
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



