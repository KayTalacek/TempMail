//
//  ViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit
import SnapKit
import CryptoSwift

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let email = UILabel()
    let emailInput = UITextField()
    let domainsTable = UITableView()
    
    var availableDomains : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initView()
        checkForDomains()
        initTable()
        domainsTable.delegate = self
        domainsTable.dataSource = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "TempMail"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableDomains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = domainsTable.dequeueReusableCell(withIdentifier: "domainCell", for: indexPath) as! DomainsViewCell
        cell.textLabel?.text = availableDomains[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func initView() {
        let padding = 30
        let savedEmail = DataHandler.getEmail()
        if savedEmail == "" {
            email.text = "Nebyl nastaven žádný email"
            email.textColor = .lightGray
        } else {
            setEmail(savedEmail)
        }
        email.textAlignment = .center
        email.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(email)
        email.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(170)
            make.height.equalTo(50)
        }
        
        let setBTN = UIButton()
        setBTN.setImage(UIImage(systemName: "arrow.right.circle.fill"),for: .normal)
        setBTN.addTarget(self, action: #selector(btnWorker(sender:)), for: .touchUpInside)
        view.addSubview(setBTN)
        setBTN.snp.makeConstraints { (make) in
            make.top.equalTo(email.snp.bottom)
            make.right.equalTo(self.view).offset(-padding)
            make.height.width.equalTo(padding)
        }

        view.addSubview(emailInput)
        emailInput.layer.borderWidth = 1
        emailInput.placeholder = "Zadejte email..."
        emailInput.layer.cornerRadius = 8
        emailInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailInput.frame.height))
        emailInput.leftViewMode = .always
        emailInput.keyboardType = .emailAddress
        emailInput.snp.makeConstraints { (make) in
            make.top.equalTo(email.snp.bottom)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(setBTN.snp.left)
            make.height.equalTo(30)
        }
        
        let domainsLabel = UILabel()
        domainsLabel.text = "Dostupné domény:"
        view.addSubview(domainsLabel)
        domainsLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.height.equalTo(20)
        }
        
        let domainsTableView = UIView()
        domainsTableView.layer.cornerRadius = 8
        domainsTableView.layer.borderWidth = 1
        domainsTableView.layer.borderColor = UIColor(named: "black")?.cgColor
        view.addSubview(domainsTableView)
        domainsTableView.snp.makeConstraints { (make) in
            make.top.equalTo(domainsLabel.snp.bottom).offset(5)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-padding)
        }
        
        domainsTableView.addSubview(domainsTable)
        domainsTable.snp.makeConstraints { (make) in
            make.edges.equalTo(domainsTableView)
        }
        
    }
    
    func initTable() {
        domainsTable.register(DomainsViewCell.self, forCellReuseIdentifier: "domainCell")
    }
    
    func checkForDomains() {
        ApiHandler.getDomains { (data) in
            if let receivedData = data {
                self.availableDomains = receivedData
                self.domainsTable.reloadData()
            }
        }
    }
    
    func setEmail(_ emailInput: String) {
        email.text = "\(emailInput)"
        email.textColor = .black
    }
    
    @objc func btnWorker(sender: UIButton) {
        if let input = emailInput.text {
            var itsOkay = false
            for domain in availableDomains where input.contains("\(domain)") {
                itsOkay = true
            }
            if itsOkay {
                setEmail(input)
                DataHandler.saveEmail(input)
                emailInput.text = ""
            } else {
                badEmail()
            }
        }
    }
    
    func badEmail() {
        let error = UIAlertController(title: "Ouha!", message: "Zadejte, prosím, platnou doménu.", preferredStyle: .alert)

        error.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        self.present(error, animated: true, completion: nil)
    }
    
}

