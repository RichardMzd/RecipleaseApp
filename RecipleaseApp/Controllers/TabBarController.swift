//
//  TabBarViewController.swift
//  Reciplease
//
//  Created by Richard Arif Mazid on 27/09/2022.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleBar()
        view.backgroundColor = .darkGray
        navigationItem.title = "Reciplease"
    }
        
    func setupVC() {
        viewControllers = [createNavController(for: SearchViewController(), title: NSLocalizedString("Search", comment: "")), createNavController(for: FavoritesViewController(), title: NSLocalizedString("Favorites", comment: ""))]
    }
    
    func setTitleBar() {
        self.viewControllers?[0].tabBarItem.title = NSLocalizedString("Searching", comment: "")
        self.viewControllers?[1].tabBarItem.title = NSLocalizedString("Favorites", comment: "")
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:UIFont(name: "chalkduster", size: 25)]
        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        tabBar.backgroundColor = .darkGray
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String) -> UIViewController {
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "chalkduster", size: 25) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationBarAppearance.backgroundColor = .darkGray
        }
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        rootViewController.navigationItem.title = "Reciplease"
        navController.navigationBar.backgroundColor = .brown
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "chalkduster", size: 25) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        return navController
    }
}

