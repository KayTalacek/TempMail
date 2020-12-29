//
//  EmailData.swift
//  TempMail
//
//  Created by Lukas Talacek on 26.12.2020.
//

import Foundation
import ObjectMapper

class EmailData: Mappable {
    var id: String?
    var sender: String?
    var subject: String?
    var textSnippet: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["mid"]
        sender <- map["textFrom"]
        subject <- map["textSubject"]
        textSnippet <- map["textSnippet"]
    }
}
