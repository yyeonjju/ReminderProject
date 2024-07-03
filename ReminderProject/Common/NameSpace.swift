//
//  NameSpace.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import Foundation

enum TodoEditItem : String, CaseIterable  {
    case expirationDate = "마감일"
    case tag = "태그"
    case priority = "우선순위"
    case image = "이미지 추가"
}
