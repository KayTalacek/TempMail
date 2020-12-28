//
//  EmailsViewCell.swift
//  TempMail
//
//  Created by Lukas Talacek on 24.12.2020.
//

import UIKit

class EmailsViewCell: UITableViewCell {

    let padding: CGFloat = 5
    let roundedRectView = UIView()
    let mainView = UIView()
    let arrowImg = UIImageView()
    let senderLabel = UILabel()
    let subjectLabel = UILabel()
    let snippetLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setupCell() {
        contentView.addSubview(roundedRectView)
        roundedRectView.layer.shadowColor = UIColor.lightGray.cgColor
        roundedRectView.layer.shadowOpacity = 0.4
        roundedRectView.layer.shadowOffset = .zero
        roundedRectView.layer.shadowRadius = 5
        roundedRectView.layer.cornerRadius = 5
        roundedRectView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        roundedRectView.frame = CGRect(x: padding, y: padding, width: frame.width - 2 * padding, height: frame.height - 2 * padding)
        roundedRectView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(5)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView).offset(-5)
            make.height.equalTo(105)
        }
            
        roundedRectView.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(roundedRectView).offset(20)
            make.left.equalTo(roundedRectView).offset(20)
            make.right.equalTo(roundedRectView).offset(-20)
            make.bottom.equalTo(roundedRectView).offset(-20)
        }
        
        mainView.addSubview(senderLabel)
        senderLabel.font = UIFont.boldSystemFont(ofSize: 16)
        senderLabel.textColor = .black
        senderLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(mainView)
        }
        
        mainView.addSubview(arrowImg)
        arrowImg.image = UIImage(systemName: "chevron.right")
        arrowImg.tintColor = .gray
        arrowImg.snp.makeConstraints { (make) in
            make.top.right.equalTo(mainView)
            make.width.equalTo(8)
            make.height.equalTo(15)
        }
        
        mainView.addSubview(subjectLabel)
        subjectLabel.textColor = .darkGray
        subjectLabel.font = subjectLabel.font.withSize(15)
        subjectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(senderLabel.snp.bottom)
            make.left.equalTo(mainView)
            make.right.equalTo(arrowImg.snp.left)
        }
        
        mainView.addSubview(snippetLabel)
        snippetLabel.textColor = .lightGray
        snippetLabel.textAlignment = .center
        snippetLabel.font = snippetLabel.font.withSize(14)
        snippetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(subjectLabel.snp.bottom).offset(padding)
            make.right.equalTo(mainView.snp.right)
            make.left.equalTo(mainView.snp.left)
            make.bottom.equalTo(mainView.snp.bottom)
        }
    }
    
    public func passData(data: EmailData) {
        let passedVal = data
        
        if let sender = passedVal.sender{
            senderLabel.text = sender.replacingOccurrences(of: "\"", with: "")
        }
        
        if let subject = passedVal.subject {
            subjectLabel.text = subject
        }
        
        snippetLabel.text = "Klikněte pro zobrazení zprávy"
    }
}
