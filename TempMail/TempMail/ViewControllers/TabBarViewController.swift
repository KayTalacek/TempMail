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
        let mainVC = MainViewController()
        mainVC.tabBarItem.image = UIImage(systemName: "envelope")
        mainVC.tabBarItem.selectedImage = UIImage(systemName: "envelope.fill")
        mainVC.tabBarItem.title = "Email"
        
        let listVC = ListViewController()
        listVC.tabBarItem.image = UIImage(systemName: "list.bullet")
        listVC.tabBarItem.selectedImage = UIImage(systemName: "list.bullet.indent")
        listVC.tabBarItem.title = "Doručené"
        
        viewControllers = [mainVC, listVC]
    }

}
