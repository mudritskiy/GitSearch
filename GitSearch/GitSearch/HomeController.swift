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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CellClass.self, forCellWithReuseIdentifier: "cellId")
        
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
    
    func strucToArray(resource: SearchItem) -> Dictionary<String, String> {
        var result = [String: String]()
        let mirror = Mirror(reflecting: resource)
        for child in mirror.children  {
            if child.label! != "owner" {
                if let value = child.value as? String {
                    result[child.label!] = value
                } else {
                    result[child.label!] = "test" //(value(forKey: "login") as! String)
                }
            }
        }
    return result
    }
    
    func cellProcessing(index: Int, cellInstance: CellClass? = nil) {
        if let gitInfo = self.gitRep {
            if let gitItems = gitInfo.items {
                let mirror = Mirror(reflecting: gitItems[index])
                if let cell = cellInstance {
                    // dwar information
                    
                    cell.title.text = gitItems[index].name!
//                    var value: String
//                    let itemsToShow = ["description", "language", "owner", "created_at"]
                    let item = strucToArray(resource: gitItems[index])
//                    print(item)
//                    for itemToShow in itemsToShow {
//                        if itemToShow == "owner" {
//                            value = mirror.children[itemToShow].login
//                        } else {
//
//                        }
                        cell.subTitle.text = """
                        description: \(item["description"])
                        language: \(item["language"])
                        owner: \(item["owner"])
                        created_at: \(item["created_at"])
                        """
//                    }
                    //cell.subTitle.text =
                    
                    

                } else {
                    // open cell
                    let newVC = CellDetailTableView() //CellDetail()
//                    let mirror = Mirror(reflecting: gitItems[index])
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

