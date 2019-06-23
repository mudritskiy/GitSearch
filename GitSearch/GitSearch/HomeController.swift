//
//  ViewController.swift
//  GitSearch
//
//  Created by Vldmr on 6/4/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate func oldVersionOfCode() {
        let lableFont = UIFont.boldSystemFont(ofSize: 34)
        let borderTop = 20
        let viewWidth = Int(self.view.frame.size.width)
        let labelSeparator = (width: Int(viewWidth/3), height: 50)
        
        let labelGit = UILabel(frame: CGRect(x: 0, y: borderTop, width: labelSeparator.width, height: labelSeparator.height))
        labelGit.text = "GIT"
        labelGit.textAlignment = .right
        labelGit.textColor = UIColor.white
        labelGit.backgroundColor = UIColor(red:0.98, green:0.56, blue:0.04, alpha:1.0) // orange
        labelGit.font = lableFont
        self.view.addSubview(labelGit)
        
        let labelSearch = UILabel(frame: CGRect(x: labelSeparator.width, y: borderTop, width: (viewWidth - labelSeparator.width), height: labelSeparator.height))
        labelSearch.text = "SEARCH"
        labelSearch.textAlignment = .left
        labelSearch.textColor = UIColor.white
        labelSearch.backgroundColor = UIColor(red:0.41, green:0.56, blue:0.81, alpha:1.0) // blue
        labelSearch.font = lableFont
        self.view.addSubview(labelSearch)
    }
    
    var gitRep: SearchInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CellClass.self, forCellWithReuseIdentifier: "cellId")
        
        let urlQuery = "https://api.github.com/search/repositories?q=tetris&sort=stars&order=desc"
        guard let urlGit = URL(string: urlQuery) else { return }
 
        URLSession.shared.dataTask(with: urlGit) { data, response, error in
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 { print(response) }
            }
            guard let data = data else { return }
            do {
                self.gitRep = try JSONDecoder().decode(SearchInfo.self, from: data)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
           } catch let errorLbl {
                print(errorLbl)
            }
        }.resume()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = gitRep?.items?.count else { return 0 }
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! CellClass
        if let gitInfo = self.gitRep {
            if let gitItems = gitInfo.items {
                cell.title.text = gitItems[indexPath.row].name!
                cell.title.sizeToFit()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }

}

class CellClass: UICollectionViewCell, UICollectionViewDelegateFlowLayout {

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "arial", size: 16.0)
        label.textColor = UIColor.black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
//        self.title.sizeThatFits(CGSize(width: frame.width, height: 100.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchInfo: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: Array<Item>?
    
    struct Item: Decodable {
        let id: Int?
        let name: String?
        let html_url: String?
        let description: String?
        let created_at: String?
        let updated_at: String?
        let language: String?
        let score: Double?
        let owner: Owners?
    }
    
    struct Owners: Decodable {
        let login: String?
        let id: Int?
        let html_url: String?
    }
    
}

