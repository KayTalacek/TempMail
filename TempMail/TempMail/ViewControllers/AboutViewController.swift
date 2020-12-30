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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "O aplikaci"
    }
    
    func initView() {
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.textColor = .black
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
        infoLabel.text = "Vytvořil Bc. Lukáš Talacek (2020)\n\nv rámci své semestrální práce\n\ndo předmětu AK7MT"
        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
            make.height.equalTo(self.view.frame.width)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "TempMail"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 40, weight: .black)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(infoLabel.snp.top)
            make.left.equalTo(self.view).offset(30)
            make.right.equalTo(self.view).offset(-30)
        }
    }
}
