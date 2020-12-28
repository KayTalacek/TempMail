//
//  ViewController.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var segmented = UISegmentedControl()
    let options = ["Automatický", "Manuální"]
    
    let email = UILabel()
    let copyBTN = UIButton()
    
    let emailPickerInput = UITextField()
    let emailPicker = UIPickerView()
    let generateBTN = UIButton()
    
    let emailInput = UITextField()
    let setBTN = UIButton()
    let domainsTitle = UILabel()
    let domainsTable = UITableView()

    var availableDomains: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        checkForDomains()
        initView(padding: 30)
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
        emailPickerInput.text = availableDomains[row]
    }
    
    func initView(padding: Int) {
        segmented = UISegmentedControl(items: options)
        segmented.selectedSegmentIndex = 0
        segmented.layer.cornerRadius = 8
        segmented.backgroundColor = .lightGray
        segmented.layer.borderColor = UIColor.gray.cgColor
        segmented.layer.borderWidth = 2
        segmented.selectedSegmentTintColor = .systemBlue
        segmented.addTarget(self, action: #selector(setOption(sender:)), for: .valueChanged)
        
        view.addSubview(segmented)
        segmented.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(padding)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.height.equalTo(padding*2)
        }
        
        let savedEmail = DataHandler.getEmail()
        if savedEmail == "" {
            email.text = "Nebyl nastaven žádný email"
            email.textColor = .lightGray
            copyBTN.isEnabled = false
        } else {
            setEmail(savedEmail)
            copyBTN.isEnabled = true
        }
        email.textAlignment = .center
        email.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(email)
        email.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.bottom.equalTo(self.view.snp.centerY).offset(-padding*3)
            make.height.equalTo(50)
        }
        
        copyBTN.setTitle("Kopírovat", for: .normal)
        let attributedTitle = NSAttributedString(string: "Kopírovat", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        copyBTN.setAttributedTitle(attributedTitle, for: .normal)
        copyBTN.layer.cornerRadius = 8
        copyBTN.backgroundColor = .link
        copyBTN.addTarget(self, action: #selector(copyToClipboard(sender:)), for: .touchUpInside)
        view.addSubview(copyBTN)
        copyBTN.snp.makeConstraints { (make) in
            make.top.equalTo(email.snp.bottom)
            make.right.equalTo(self.view.snp.right).offset(-padding)
            make.height.equalTo(30)
            make.width.equalTo(padding*3)
        }
        
        view.addSubview(emailPickerInput)
        emailPickerInput.layer.borderWidth = 1
        emailPickerInput.attributedPlaceholder = NSAttributedString(string: "Vyberte doménu...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailPickerInput.inputView = emailPicker
        emailPickerInput.layer.cornerRadius = 8
        emailPickerInput.textColor = .black
        emailPickerInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailPickerInput.frame.height))
        emailPickerInput.leftViewMode = .always
        emailPickerInput.keyboardType = .emailAddress
        emailPickerInput.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.centerY)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.height.equalTo(30)
        }

        generateBTN.setTitle("Vygenerovat email", for: .normal)
        generateBTN.backgroundColor = .systemBlue
        generateBTN.layer.cornerRadius = 8
        generateBTN.addTarget(self, action: #selector(btnDown(sender:)), for: .touchDown)
        generateBTN.addTarget(self, action: #selector(generateEmail(sender:)), for: .touchUpInside)
        view.addSubview(generateBTN)
        generateBTN.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(padding)
            make.left.equalTo(self.view.snp.left).offset(padding)
            make.right.equalTo(self.view.snp.right).offset(-padding)
            make.height.equalTo(40)
        }
        
        emailInput.layer.borderWidth = 1
        emailInput.attributedPlaceholder = NSAttributedString(string: "Zadejte email s platnou doménou...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailInput.layer.cornerRadius = 8
        emailInput.textColor = .black
        emailInput.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailInput.frame.height))
        emailInput.leftViewMode = .always
        emailInput.keyboardType = .emailAddress
        emailInput.isHidden = true
        view.addSubview(emailInput)
        emailInput.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.centerY)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.height.equalTo(30)
        }
        
        setBTN.setTitle("Nastavit email", for: .normal)
        setBTN.backgroundColor = .systemBlue
        setBTN.layer.cornerRadius = 8
        setBTN.isHidden = true
        setBTN.addTarget(self, action: #selector(btnDown(sender:)), for: .touchDown)
        setBTN.addTarget(self, action: #selector(restoreEmail(sender:)), for: .touchUpInside)
        view.addSubview(setBTN)
        setBTN.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.centerY).offset(padding)
            make.left.equalTo(self.view.snp.left).offset(padding)
            make.right.equalTo(self.view.snp.right).offset(-padding)
            make.height.equalTo(40)
        }
        
        domainsTable.backgroundColor = .none
        domainsTable.layer.borderWidth = 1
        domainsTable.layer.borderColor = UIColor.black.cgColor
        domainsTable.layer.cornerRadius = 8
        domainsTable.isHidden = true
        view.addSubview(domainsTable)
        domainsTable.snp.makeConstraints { (make) in
            make.top.equalTo(setBTN.snp.bottom).offset(padding)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-padding)
        }
        
        domainsTitle.text = "Dostupné domény:"
        domainsTitle.textColor = .black
        domainsTitle.font = UIFont.systemFont(ofSize: 14)
        domainsTitle.isHidden = true
        view.addSubview(domainsTitle)
        domainsTitle.snp.makeConstraints { (make) in
            make.bottom.equalTo(domainsTable.snp.top)
            make.left.equalTo(self.view).offset(padding)
            make.right.equalTo(self.view).offset(-padding)
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
    
    @objc func copyToClipboard(sender: UIButton) {
        UIPasteboard.general.string = email.text
    }
    
    @objc func setOption(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            if generateBTN.isHidden {
                emailPickerInput.isHidden = false
                generateBTN.isHidden = false
            }
            if !setBTN.isHidden {
                emailInput.isHidden = true
                setBTN.isHidden = true
                domainsTitle.isHidden = true
                domainsTable.isHidden = true
            }
            break
        case 1:
            if !generateBTN.isHidden {
                emailPickerInput.isHidden = true
                generateBTN.isHidden = true
            }
            if setBTN.isHidden {
                emailInput.isHidden = false
                setBTN.isHidden = false
                domainsTitle.isHidden = false
                domainsTable.isHidden = false
            }
            break
        default:
            break
        }
    }
    
    func setEmail(_ emailInput: String) {
        email.text = "\(emailInput)"
        email.textColor = .black
    }
    
    @objc func btnDown(sender: UIButton) {
        generateBTN.backgroundColor = UIColor(red: 0, green: 0.4, blue: 0.7, alpha: 1)
    }
    
    @objc func generateEmail(sender: UIButton) {
        if let input = emailPickerInput.text {
            var itsOkay = false
            for domain in availableDomains where input.contains("\(domain)") {
                itsOkay = true
            }
            if itsOkay {
                ApiHandler.createMail(domain: input) { (data) in
                    if let newEmail = data {
                        self.setEmail(newEmail)
                        self.emailPickerInput.text = ""
                    }
                }
            } else {
                badEmail()
            }
        }
        generateBTN.backgroundColor = .systemBlue
    }
    
    @objc func restoreEmail(sender: UIButton) {
        if let input = emailInput.text {
            var itsOkay = false
            for domain in availableDomains where input.contains("\(domain)") {
                itsOkay = true
            }
            if itsOkay {
                ApiHandler.restoreEmail(email: input) { (data) in
                    if let newEmail = data {
                        self.setEmail(newEmail)
                        self.emailInput.text = ""
                    }
                }
            } else {
                badEmail()
            }
        }
        generateBTN.backgroundColor = .systemBlue
    }
    
    func badEmail() {
        let error = UIAlertController(title: "Ouha!", message: "Vyberte, prosím, platnou doménu.", preferredStyle: .alert)
        error.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        self.present(error, animated: true, completion: nil)
    }
}

