//
//  ListViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Doručené"
    }

}
