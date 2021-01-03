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
    let timeLabel = UILabel()
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
        
        timeLabel.font = timeLabel.font.withSize(18)
        timeLabel.textColor = .gray
        senderSubjectView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(senderSubjectView.snp.right).offset(-padding)
            make.top.equalTo(senderSubjectView.snp.top).offset(padding)
            make.height.equalTo(height)
        }
        
        senderSubjectView.addSubview(senderLabel)
        senderLabel.textColor = .black
        senderLabel.font = UIFont.boldSystemFont(ofSize: 20)
        senderLabel.snp.makeConstraints { (make) in
            make.top.equalTo(senderSubjectView.snp.top).offset(padding)
            make.left.equalTo(senderSubjectView).offset(padding)
//            make.right.equalTo(timeLabel.snp.left).offset(-padding)
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
        messageField.isEditable = false
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
            
//            if let sentAtRaw = data.date {
//                let dateFormatterGet = DateFormatter()
//                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//                let dateFormatterPrint = DateFormatter()
//                dateFormatterPrint.dateFormat = "HH:mm"
//
//                if let sent = dateFormatterGet.date(from: sentAtRaw) {
//                    if let sentMod = Calendar.current.date(byAdding: .hour, value: -6, to: sent) {
//                        timeLabel.text = dateFormatterPrint.string(from: sentMod)
//                    }
//                } else {
//                    print("There was an error decoding the date of birth.")
//                }
//            }
            
            if let sentAtRaw = data.date {
                if let sent = StringToDateHelper.shared.formatDate(sentAtRaw) {
                    if let sentMod = Calendar.current.date(byAdding: .hour, value: -6, to: sent) {
                        timeLabel.text = DateToStringHelper.shared.formatDate(sentMod)
                    }
                }
            }
            
            ApiHandler.getSingleEmail(messageID: mid) { (message) in
                if let msg = message {
                    self.messageField.text = msg
                }
            }
        }
    }
}
