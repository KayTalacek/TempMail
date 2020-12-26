//
//  DataHandler.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import Foundation

class DataHandler {
    static let defaults = UserDefaults.standard

<<<<<<< Updated upstream
    static func saveEmail(_ value: String) {
        defaults.set(value, forKey: "temporaryEmail")
=======
    static func saveEmail(email: String, key: String) {
        defaults.set(email, forKey: "temporaryEmail")
        saveEmailKey(key)
>>>>>>> Stashed changes
    }
    static func getEmail() -> String {
        return defaults.object(forKey: "temporaryEmail") as? String ?? ""
    }
<<<<<<< Updated upstream
=======
    static func saveEmailKey(_ key: String) {
        defaults.set(key, forKey: "temporaryEmailKey")
    }
    static func getEmailKey() -> String {
        return defaults.object(forKey: "temporaryEmailKey") as? String ?? ""
    }
>>>>>>> Stashed changes
}
