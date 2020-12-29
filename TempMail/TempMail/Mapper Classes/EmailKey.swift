//
//  EmailKey.swift
//  TempMail
//
//  Created by Lukas Talacek on 26.12.2020.
//

import Foundation
import ObjectMapper

class EmailKey: Mappable {
    var username: String?
    var key: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        username <- map["items.username"]
        key <- map["items.key"]
    }
}
