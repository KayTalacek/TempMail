//
//  ListViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let emailsTable = UITableView()
    var allEmails: [EmailData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        loadData()
        
        view.addSubview(emailsTable)
        emailsTable.register(EmailsViewCell.self, forCellReuseIdentifier: "emailCell")
        emailsTable.backgroundColor = UIColor(named: "listBg")
        emailsTable.separatorStyle = .none
        emailsTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.emailsTable.estimatedRowHeight = 150
        
        emailsTable.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        emailsTable.delegate = self
        emailsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Doručené"
        let rightBTN = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(reload(_:)))
        navigationController?.navigationItem.rightBarButtonItem = rightBTN
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = emailsTable.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath) as! EmailsViewCell
        cell.passData(data: allEmails[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteMessage = UIContextualAction(style: .normal, title: "Urgentní\nzpráva OL") {
            [weak self] (action, view, completionHandler) in
                self?.swipeAction(value: "\nUrgentní zpráva OL")
                completionHandler(true)
        }
        deleteMessage.image = UIImage(systemName: "exclamationmark.bubble.fill")
        deleteMessage.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteMessage])
    }
    
    func swipeAction(value: String) {
        print(value)
    }
    
    func loadData() {
        ApiHandler.getEmails { (data) in
            if let receivedData = data {
                self.allEmails = receivedData
                print("LOG in list \(receivedData.count)")
                print("SenderLOG: \(self.allEmails.first?.sender)")
                self.emailsTable.reloadData()
            }
        }
    }
    
    @objc func reload(_ sender: UIBarButtonItem) {
        loadData()
    }
    
}
