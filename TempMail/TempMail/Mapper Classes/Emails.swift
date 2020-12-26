//
//  Emails.swift
//  TempMail
//
//  Created by Lukas Talacek on 26.12.2020.
//

import Foundation
import ObjectMapper

class Emails: Mappable {
    var emails: [EmailData]?
    
    required init?(map: Map) {
    }

    func mapping(map: Map) {
        emails <- map["items"]
    }
}
