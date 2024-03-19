//
//  GUTabBarController.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/13/24.
//

import UIKit

class GUTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UITabBar.appearance().tintColor         = .systemGreen
        UITabBar.appearance().backgroundColor   = .systemBackground
        viewControllers                         = [createSearchNC(), createFavoritesNC()]
    }
    
    // Navigation Controller holds Search View Controller
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // Navigation Controller holds Favorites List View Controller
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC         = FavoritesListVC()
        favoritesListVC.title       = "Favorites"
        favoritesListVC.tabBarItem  = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }

}
