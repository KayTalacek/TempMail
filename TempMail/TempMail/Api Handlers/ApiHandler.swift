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
        "x-rapidapi-host": "privatix-temp-mail-v1.p.rapidapi.com"
    ]
    
    static func getDomains(completion: @escaping ([String]?) -> Void) {
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.colorAnimation = .blue
        ProgressHUD.show()
        AF.request("https://privatix-temp-mail-v1.p.rapidapi.com/request/domains/", method: .get, encoding: URLEncoding.default, headers: headers).responseJSON {response in
            switch response.result {
            case .success(let value):
                let availableDomains = value as? [String]
                completion(availableDomains)
                ProgressHUD.dismiss()
                
            default:
                break
            }
        }
    }
}
