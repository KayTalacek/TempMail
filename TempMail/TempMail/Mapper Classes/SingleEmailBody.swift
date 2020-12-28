//
//  SingleEmailBody.swift
//  TempMail
//
//  Created by Lukas Talacek on 27.12.2020.
//

import Foundation
import ObjectMapper

class SingleEmailBody: Mappable {
    var body: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        body <- map["items.body"]
    }
}
