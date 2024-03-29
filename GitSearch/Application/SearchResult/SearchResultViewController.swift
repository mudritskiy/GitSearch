//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

final class SearchResultViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let defaultReuseId = "default"
    private var items = [SearchItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = StringsLocalized.SearchResult.title
        
        collectionView?.backgroundColor = .secondaryTint
        collectionView?.register(SearchResultCell.self, forCellWithReuseIdentifier: defaultReuseId)
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: view.frame.size.width - 30, height: 120)
        collectionView?.collectionViewLayout = layout
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: defaultReuseId, for: indexPath) as! SearchResultCell
        let item = items[indexPath.row]
        cell.setup(with: item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let newVC = RepoInfoViewController(item: item)
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    init(data: SearchInfo) {
        items = data.items ?? []
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
