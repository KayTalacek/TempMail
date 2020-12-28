//
//  Emails.swift
//  TempMail
//
//  Created by Lukas Talacek on 26.12.2020.
//

import Foundation
import ObjectMapper

class Emails: Mappable {
    var code: Int?
    var msg: String?
    var emails: [EmailData]?
    
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        emails <- map["items"]
    }
}
