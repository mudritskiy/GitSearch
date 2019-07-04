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

    func fetchRepositoriesHeader(from urlString: String, completion: @escaping (SearchInfo) -> ()) {
        
        guard let urlGit = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: urlGit) { data, response, error in
            if error != nil { return }
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 { print(response) }
            }
            guard let data = data else { return }
            do {
                let gitRep = try JSONDecoder().decode(SearchInfo.self, from: data)
                completion(gitRep)
            } catch let errorLbl {
                print(errorLbl)
            }
            }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CellClass.self, forCellWithReuseIdentifier: "cellId")
        
        let urlQuery = "https://api.github.com/search/repositories?q=tetris&sort=stars&order=desc"
        fetchRepositoriesHeader(from: urlQuery) { gitRep in
            self.gitRep = gitRep
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width-60, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellProcessing(index: indexPath.row)
    }
    
    func cellProcessing(index: Int, cellInstance: CellClass? = nil) {
        if let gitInfo = self.gitRep {
            if let gitItems = gitInfo.items {
                if let cell = cellInstance {
                    // dwar information
                    cell.title.text = gitItems[index].name!
                } else {
                    // open cell
                    let newVC = CellDetailTableView() //CellDetail()
                    let mirror = Mirror(reflecting: gitItems[index])
                    for child in mirror.children  {
                        if child.label! != "owner" {
                            if let value = child.value as? String {
                            newVC.repInfo[child.label!] = value
                            }
                        }
                    }
                    navigationController?.pushViewController(newVC, animated: true)
                }
            }
        }

    }
}

class CellClass: UICollectionViewCell, UICollectionViewDelegateFlowLayout {

    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "arial", size: 16.0)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subTitle: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.font = UIFont(name: "arial", size: 16.0)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
        addSubview(subTitle)
        
        let viewDictionary = ["v0": title, "v1": subTitle]
        var verticalVisualFormat = "V:|-"
        for element in viewDictionary.keys.sorted(by: <) {
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[\(element)]-30-|", options: [], metrics: nil, views: viewDictionary))
            verticalVisualFormat += "[\(element)(50)]-"
        }
        //verticalVisualFormat.remove(at: verticalVisualFormat.index(before: verticalVisualFormat.endIndex))
        verticalVisualFormat += "|"
        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: [], metrics: nil, views: viewDictionary))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SearchInfo: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: Array<SearchItem>?
    
}

class SearchItem: Decodable {
    let id: Int?
    let name: String?
    let html_url: String?
    let description: String?
    let created_at: String?
    let updated_at: String?
    let language: String?
    let score: Double?
    let owner: Owners?
    
    struct Owners: Decodable {
        let login: String?
        let id: Int?
        let html_url: String?
    }
}

