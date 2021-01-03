//
//  MyDateFormatter.swift
//  TempMail
//
//  Created by Lukas Talacek on 01.01.2021.
//

import Foundation

private protocol DtSFormatterType {
    func string(from date: Date) -> String
}

class DateToStringHelper {

    static let shared = DateToStringHelper()

    private let dtsDateFormatter: DtSFormatterType = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    func formatDate(_ date: Date) -> String {
        let formattedDate = dtsDateFormatter.string(from: date)
        return formattedDate
    }
}

extension DateFormatter: DtSFormatterType { }
