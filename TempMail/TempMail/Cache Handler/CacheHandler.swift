//
//  CacheHandler.swift
//  TempMail
//
//  Created by Lukas Talacek on 28.12.2020.
//

import Foundation

class CacheHandler{
    static let msgCache = NSCache<NSString,NSString>()

//    static let mailCache = NSCache<NSString,EmailData>()

//    static func cacheEmail(email: EmailData) {
//        if let mid = email.id {
//            mailCache.setObject(email, forKey: NSString(string: mid))
//        }
//    }
//
//    static func getCachesEmail() -> String {
//        if let cachedVersion = mailCache.object(forKey: NSString(string: mid)) {
//            // use the cached version
//            myObject = cachedVersion
//        }
//
//        return defaults.object(forKey: "temporaryEmail") as? String ?? ""
//    }

    static func cacheMessage(emailID: String, message: String) {
            msgCache.setObject(NSString(string: message), forKey: NSString(string: emailID))
    }
    static func getCachedMessage(emailID: String) -> String {
        if let message = msgCache.object(forKey: NSString(string: emailID)) {
            return message as String
        } else {
            return "null"
        }
    }
}
