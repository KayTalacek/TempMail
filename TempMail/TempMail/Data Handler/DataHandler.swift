//
//  DataHandler.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import Foundation

class DataHandler {
    static let defaults = UserDefaults.standard

    static func saveEmail(_ value: String) {
        defaults.set(value, forKey: "temporaryEmail")
    }

    static func saveEmail(email: String, key: String) {
        defaults.set(email, forKey: "temporaryEmail")
        saveEmailKey(key)
    }
        
    static func getEmail() -> String {
        return defaults.object(forKey: "temporaryEmail") as? String ?? ""
    }

    static func saveEmailKey(_ key: String) {
        defaults.set(key, forKey: "temporaryEmailKey")
    }
    static func getEmailKey() -> String {
        return defaults.object(forKey: "temporaryEmailKey") as? String ?? ""
    }
}
