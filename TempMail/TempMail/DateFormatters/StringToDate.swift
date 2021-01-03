//
//  DateToString.swift
//  TempMail
//
//  Created by Lukas Talacek on 01.01.2021.
//

import Foundation

private protocol StDFormatterType {
    func date(from string: String) -> Date?
}

class StringToDateHelper {

    static let shared = StringToDateHelper()

    private let stdDateFormatter: StDFormatterType = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()

    func formatDate(_ string: String) -> Date? {
        return stdDateFormatter.date(from: string)
    }
}

extension DateFormatter: StDFormatterType { }
