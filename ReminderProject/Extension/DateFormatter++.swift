//
//  DateFormatter++.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import Foundation


extension DateFormatter {
    enum FormatString : String {
        case yearDotMonth = "yyyy.MM"
        case yearDotMonthDotDay = "yyyy.MM.dd"
    }
    
    
    static private let krDateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .init(identifier: "ko_KR")
        return formatter
    }()
    
    static func getDateFormatter(format : FormatString) -> DateFormatter {
        let formatter = krDateFormatter
        formatter.dateFormat = format.rawValue
        return formatter
    }
}
