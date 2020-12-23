//
//  ViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initView()
    }
    func initView() {
        let text = UITextView()
        text.text = "Hello user"
        text.textAlignment = .center
        
        view.addSubview(text)
        text.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.safeAreaLayoutGuide)
            make.width.height.equalTo(self.view.snp.width).dividedBy(3)
        }
    }

}

