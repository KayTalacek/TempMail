//
//  AboutViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 30.12.2020.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        initView()
    }
    
    func initView() {
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.textColor = .black
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont(name: "AppleSDGothicNeo-Ultra-Light ", size: 40)
        infoLabel.text = "Vytvořil Bc. Lukáš Talacek (2020)\n\nv rámci své semestrální práce\n\ndo předmětu AK7MT"
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(self.view.frame.width)
        }
    }
}

//<section style="text-align:center; margin-top: 100px;">
//  <ion-label>
//    Vytvořil Lukáš Talacek (2020) <br>
//    v rámci své semestrální práce. <br><br>
//  </ion-label>
//  <ion-label>
//    Aplikace využívá API temp-mail.org
//  </ion-label>
