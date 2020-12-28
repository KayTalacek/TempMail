//
//  ListViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let noEmails = UILabel()
    let refreshTable = UIRefreshControl()
    let emailsTable = UITableView()
    var allEmails: [EmailData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        noEmails.isHidden = true
        noEmails.textAlignment = .center
        noEmails.text = "Vaše schránka je prázdná"
        noEmails.textColor = .gray
        view.addSubview(noEmails)
        noEmails.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.right.equalTo(self.view)
        }
                
        view.addSubview(emailsTable)
        emailsTable.register(EmailsViewCell.self, forCellReuseIdentifier: "emailCell")
        emailsTable.backgroundColor = .none
        emailsTable.separatorStyle = .none
        emailsTable.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        self.emailsTable.estimatedRowHeight = 150
        emailsTable.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        loadData()
        
        refreshTable.tintColor = .blue
        refreshTable.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        emailsTable.addSubview(refreshTable) // not required when using UITableViewController
        
        emailsTable.delegate = self
        emailsTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Doručené"
        let rightBTN = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(reload(_:)))
        navigationController?.navigationItem.rightBarButtonItem = rightBTN
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SingleEmailViewController()
        vc.passData(data: allEmails[indexPath.row])
//        vc.navigationItem.title = allEmails[indexPath.row].subject
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteMessage = UIContextualAction(style: .normal, title: "Urgentní\nzpráva OL") {
//            [weak self] (action, view, completionHandler) in
//                self?.swipeAction(value: "\nUrgentní zpráva OL")
//                completionHandler(true)
//        }
//        deleteMessage.image = UIImage(systemName: "exclamationmark.bubble.fill")
//        deleteMessage.backgroundColor = .systemRed
//        return UISwipeActionsConfiguration(actions: [deleteMessage])
//    }
//    
//    func swipeAction(value: String) {
//        print(value)
//    }
    
    @objc func refresh(_ sender: AnyObject) {
        loadData()
    }
    
    func loadData() {
        
        ApiHandler.getEmails { (data) in
            if let code = data?.code {
                if code != 200 {
                    self.expiredKey()
                    self.emailsTable.reloadData()
                }
            }
            if data?.emails?.count == 0 {
                self.noEmails.isHidden = false
            } else {
                if !self.noEmails.isHidden {
                    self.noEmails.isHidden = true
                }
                if let receivedEmails = data?.emails {
                    self.allEmails = receivedEmails
                    self.emailsTable.reloadData()
                }
            }
            if self.refreshTable.isRefreshing {
                self.refreshTable.endRefreshing()
            }
        }
        
    }
    
    @objc func reload(_ sender: UIBarButtonItem) {
        loadData()
    }
    
    func expiredKey() {
        let error = UIAlertController(title: "Ouha!", message: "Vypadá to, že platnost emailu vypršela.", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "Zrušit", style: .cancel, handler: { (_) in
        }))
        error.addAction(UIAlertAction(title: "Obnovit", style: .default, handler: { (_) in
            ApiHandler.restoreEmail(email: DataHandler.getEmail()) { (data) in
            }
        }))
        self.present(error, animated: true, completion: nil)
    }
}
