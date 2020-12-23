//
//  TabBarViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.tintColor = UIColor(named: "tabBarItem")
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        UITabBar.appearance().barTintColor = UIColor.white
        
        let mainVC = MainViewController()
        mainVC.tabBarItem.image = UIImage(systemName: "envelope")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        mainVC.tabBarItem.title = "Email"
        
        viewControllers = [mainVC]
    }

}
