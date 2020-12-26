//
//  ViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let email = UILabel()
    let emailInput = UITextField()
    let emailPicker = UIPickerView()
    let setBTN = UIButton()
    let domainsTable = UITableView()
    
    var newEmail: EmailKey?
    var availableDomains: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkForDomains()
        initView()
        initTable()
        domainsTable.delegate = self
        domainsTable.dataSource = self
        emailPicker.delegate = self
        emailPicker.dataSource = self
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
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        availableDomains.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableDomains[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        emailInput.text = availableDomains[row]
    }
    
    func initView() {
        let padding = 30
        
        view.addSubview(emailInput)
        emailInput.layer.borderWidth = 1
        emailInput.attributedPlaceholder = NSAttributedString(string: "Vyberte doménu...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailInput.inputView = emailPicker
        emailInput.layer.cornerRadius = 8
        emailInput.textColor = .black
        emailInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailInput.frame.height))
        emailInput.leftViewMode = .always
        emailInput.keyboardType = .emailAddress
        emailInput.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.centerY)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.height.equalTo(30)
        }
        
        let savedEmail = DataHandler.getEmail()
        if savedEmail == "" {
            email.text = "Nebyl nastaven žádný email"
            email.textColor = .lightGray
        } else {
            setEmail(savedEmail)
        }
        email.textAlignment = .center
        email.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(email)
        email.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.bottom.equalTo(emailInput.snp.top).offset(-padding)
            make.height.equalTo(50)
        }

        setBTN.setTitle("Vytvořit email", for: .normal)
        setBTN.backgroundColor = .systemBlue
        setBTN.layer.cornerRadius = 8
        setBTN.addTarget(self, action: #selector(btnDown(sender:)), for: .touchDown)
        setBTN.addTarget(self, action: #selector(btnWorker(sender:)), for: .touchUpInside)
        view.addSubview(setBTN)
        setBTN.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(padding)
            make.left.equalTo(self.view.snp.left).offset(padding)
            make.right.equalTo(self.view.snp.right).offset(-padding)
            make.height.equalTo(40)
        }
    }
    
    func initTable() {
        domainsTable.register(DomainsViewCell.self, forCellReuseIdentifier: "domainCell")
    }
    
    func checkForDomains() {
        ApiHandler.getDomains { (data) in
            if let receivedData = data {
                self.availableDomains.append(contentsOf: receivedData)
                self.domainsTable.reloadData()
            }
        }
    }
    
    func setEmail(_ emailInput: String) {
        email.text = "\(emailInput)"
        email.textColor = .black
    }
    
    @objc func btnDown(sender: UIButton) {
        setBTN.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.7, alpha: 1)
    }
    
    @objc func btnWorker(sender: UIButton) {
        if let input = emailInput.text {
            var itsOkay = false
            for domain in availableDomains where input.contains("\(domain)") {
                itsOkay = true
            }
            if itsOkay {
                ApiHandler.createMail(domain: input) { (data) in
                    if let newEmail = data {
                        self.setEmail(newEmail)
                        self.emailInput.text = ""
                    }
                }
            } else {
                badEmail()
            }
        }
        setBTN.backgroundColor = .systemBlue
    }
    
    func badEmail() {
        let error = UIAlertController(title: "Ouha!", message: "Zadejte, prosím, platnou doménu.", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        self.present(error, animated: true, completion: nil)
    }
}

