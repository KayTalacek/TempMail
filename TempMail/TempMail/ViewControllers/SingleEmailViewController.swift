//
//  SingleEmailViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 28.12.2020.
//

import UIKit

class SingleEmailViewController: UIViewController {

    let senderSubjectView = UIView()
    let senderLabel = UILabel()
    let subjectLabel = UILabel()
    let messageField = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        initView()
    }
    
    func initView() {
        let padding = 10
        let height = 30
        view.addSubview(senderSubjectView)
        senderSubjectView.layer.borderColor = UIColor.lightGray.cgColor
        senderSubjectView.layer.borderWidth = 1
        senderSubjectView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalTo(self.view)
            make.height.equalTo(height*5/2)
        }
        
        senderSubjectView.addSubview(senderLabel)
        senderLabel.textColor = .black
        senderLabel.font = UIFont.boldSystemFont(ofSize: 20)
        senderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(senderSubjectView.snp.top).offset(padding)
            make.left.equalTo(senderSubjectView).offset(padding)
            make.right.equalTo(senderSubjectView).offset(-padding)
            make.height.equalTo(height)
        }
        
        senderSubjectView.addSubview(subjectLabel)
        subjectLabel.textColor = .black
        subjectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(senderLabel.snp.bottom)
            make.left.equalTo(senderSubjectView.snp.left).offset(padding)
            make.right.equalTo(senderSubjectView).offset(-padding)
            make.bottom.equalTo(senderSubjectView).offset(-padding)
        }
        
        view.addSubview(messageField)
        messageField.backgroundColor = .none
        messageField.textColor = .black
        messageField.snp.makeConstraints { (make) in
            make.top.equalTo(senderSubjectView.snp.bottom)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func passData(data: EmailData) {
        
        if let mid = data.id {
            if let sender = data.sender{
                senderLabel.text = "Od: \(sender.replacingOccurrences(of: "\"", with: ""))"
            }
            
            if let subject = data.subject {
                subjectLabel.text = "Předmět: \(subject)"
            }
            ApiHandler.getSingleEmail(messageID: mid) { (message) in
                if let msg = message {
                    self.messageField.text = msg
                }
            }
        }
    }


}
