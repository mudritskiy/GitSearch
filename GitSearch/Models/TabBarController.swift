//
//  TabBarController.swift
//  GitSearch
//
//  Created by Vldmr on 11/21/20.
//  Copyright © 2020 mudritskiy. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UITabBar.appearance().tintColor = .mainTitle
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()

        let controllers = [searchTabBar, favoritesTabBar, settingsTabBar]
        self.setViewControllers(controllers , animated: animated)
    }
    
    lazy public var searchTabBar: SearchController = {
        let tabBarView = SearchController()
        tabBarView.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "defaultImage-home"), selectedImage: #imageLiteral(resourceName: "selectedImage-home"))
        return tabBarView
    }()

    lazy public var favoritesTabBar: UIViewController = {
        let tabBarView = UIViewController()
        tabBarView.view.backgroundColor = UIColor.mainTint
        tabBarView.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "defaultImage-favorites"), selectedImage: #imageLiteral(resourceName: "selectedImage-favorites"))
        return tabBarView
    }()
    
    lazy public var settingsTabBar: UIViewController = {
        let tabBarView = UIViewController()
        tabBarView.view.backgroundColor = UIColor.mainTint
        tabBarView.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "defaultImage-settings"), selectedImage: #imageLiteral(resourceName: "selectedImage-settings"))
        return tabBarView
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
