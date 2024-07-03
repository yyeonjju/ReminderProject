//
//  UtilFunc.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import Foundation

internal func isOnlyWhitespace(_ text: String?) -> Bool {
    guard let text else {return true}
    return text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
}
