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
    static func getEmail() -> String {
        return defaults.object(forKey: "temporaryEmail") as? String ?? ""
    }
}
