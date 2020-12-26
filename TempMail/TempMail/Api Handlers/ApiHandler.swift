//
//  ApiHandler.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import Foundation
import Alamofire
import ObjectMapper
import ProgressHUD

class ApiHandler {
    
    static let headers: HTTPHeaders = [
        "x-rapidapi-key": "8f0515a76amsh1a3c4ed083d7342p14b32ajsnb72c14a0c5c0",
        "x-rapidapi-host": "temp-mail22.p.rapidapi.com"
    ]
    
    static func getDomains(completion: @escaping ([String]?) -> Void) {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorAnimation = .blue
        ProgressHUD.show()
        AF.request("https://temp-mail22.p.rapidapi.com/domains", method: .get, encoding: URLEncoding.default, headers: headers).responseJSON {response in
            switch response.result {
            case .success(let value):
                if let availableDomains = value as? [[String:Any]]{
                    var domainArr: [String] = []
                    for domain in availableDomains {
                        if let clearDomain = domain["name"] {
                            domainArr.append(clearDomain as? String ?? "")
                        }
                    }
                    completion(domainArr)
                    ProgressHUD.dismiss()
                }
            default:
                break
            }
        }
    }
    
    static func createMail(domain: String, completion: @escaping (String?) -> Void) {
        AF.request("https://temp-mail22.p.rapidapi.com/get?domain=\(domain)", method: .get, encoding: URLEncoding.default, headers: headers).responseJSON {response in
            switch response.result {
            case .success(let data as [String : Any]):
                if let receivedData = EmailKey(JSON: data){
                    if let email = receivedData.username,
                       let key = receivedData.key{
                        DataHandler.saveEmail(email: email, key: key)
                        completion(email)
                    }
                }
            default:
                break
            }
        }
    }
    
//    kontrolovat pocet emailu
    static func getEmails(completion: @escaping ([EmailData]?) -> Void) {
        let email = DataHandler.getEmail()
        let key = DataHandler.getEmailKey()
        AF.request("https://temp-mail22.p.rapidapi.com/check?email=\(email)&key=\(key)", method: .get, encoding: URLEncoding.default, headers: headers).responseJSON {response in
            switch response.result {
            case .success(let data as [String : Any]):
                if let receivedData = Emails(JSON: data){
                    if let emails = receivedData.emails {
                        completion(emails)
                    }
                }
            default:
                break
            }
        }
    }
    
//    static func getSingleEmail()
    
//    static func restoreEmail(email: String)
}
