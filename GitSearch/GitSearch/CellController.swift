//
//  CellController.swift
//  GitSearch
//
//  Created by Vldmr on 7/2/19.
//  Copyright © 2019 mudritskiy. All rights reserved.
//

import UIKit

class CellController: UIViewController {
    
    let cellInfo: SearchItem
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.lightGray
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor.lightGray
//        view.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])

//        label.text = self.cellInfo.name!
//
//        self.view.backgroundColor = UIColor.white
//        self.view.addSubview(label)
////        NSLayoutConstraint.activate([
////            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
////            ])
//        //NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: [], metrics: nil, views: ["v0": label])
//        //NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0(100)]-|", options: [], metrics: nil, views: ["v0": label])
    }
    
    init(cellInfo: SearchItem) {
        self.cellInfo = cellInfo
        //print(self.cellInfo.name!)

        super.init(nibName: nil, bundle: nil)
        
        label.text = self.cellInfo.name

        self.view.backgroundColor = UIColor.lightGray
        self.view.addSubview(label)
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//           ])
        NSLayoutConstraint.constraints(withVisualFormat: "H:|10-[v0]-10|", options: [], metrics: nil, views: ["v0": label])
        NSLayoutConstraint.constraints(withVisualFormat: "V:|10-[v0]-10|", options: [], metrics: nil, views: ["v0": label])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
