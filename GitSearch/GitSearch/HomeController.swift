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
                else if let date: Date = dateFormatterGet.date(from: (child.value as? String)!) {
                    childValue = dateFormatter.string(from: date)
                }
                else if let value = child.value as? String {
                    childValue = value
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

