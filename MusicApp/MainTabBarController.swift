//
//  MainTabBarController.swift
//  MusicApp
//
//  Created by Andrey Kim on 17.08.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 255/255, green: 0/255, blue: 96/255, alpha: 1)
        
        viewControllers = [
            generateViewController(rootViewController: SearchViewController(), image: "search", title: "Search"),
            generateViewController(rootViewController: ViewController(), image: "library", title: "Library")
        ]
    }
    
    private func generateViewController(rootViewController: UIViewController, image: String, title: String) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.image = UIImage(named: image)
        navigationVC.tabBarItem.title = title
        rootViewController.navigationItem.title = title
        navigationVC.navigationBar.prefersLargeTitles = true
        return navigationVC
    }
    
    
}
