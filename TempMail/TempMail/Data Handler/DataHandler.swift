//
//  DataHandler.swift
//  TempMail
//
//  Created by Lukas Talacek on 23.12.2020.
//

import Foundation
import CryptoSwift

class DataHandler {
    static let defaults = UserDefaults.standard

    static func saveEmail(_ value: String) {
        defaults.set(value, forKey: "temporaryEmail")
        saveEmailHash(value)
    }
    static func getEmail() -> String {
        return defaults.object(forKey: "temporaryEmail") as? String ?? ""
    }
    static func saveEmailHash(_ value: String) {
        let hash = value.md5()
        defaults.set(hash, forKey: "temporaryEmailHash")
    }
    static func getEmailHash() -> String {
        return defaults.object(forKey: "temporaryEmailHash") as? String ?? ""
    }
}
