//
//  NameSpace.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit

enum TodoEditItem : String, CaseIterable  {
    case expirationDate = "마감일"
    case tag = "태그"
    case priority = "우선순위"
    case image = "이미지 추가"
    
    
    var pushTo : UIViewController.Type {
        switch self {
        case .expirationDate:
            return SettingDateViewController.self
        case .tag:
            return SettingTagViewController.self
        case .priority:
            return SettingPriorityViewController.self
        case .image:
            return SettingPhotoViewController.self
        }
    }
}



enum Assets {
    enum Color {
        static let black = UIColor(named: "black")!
        
        static let white = UIColor(named: "white")!
        
        static let blue1 = UIColor(named: "blue1")!
        static let blue2 = UIColor(named: "blue2")!
        static let blue3 = UIColor(named: "blue3")!
        
        static let gray1 = UIColor(named: "gray1")!//등록페이지 background
        static let gray2 = UIColor(named: "gray2")! //textField, tableViewCell
        static let gray3 = UIColor(named: "gray3")!
        static let gray4 = UIColor(named: "gray4")!
        static let gray5 = UIColor(named: "gray5")!
        static let gray6 = UIColor(named: "gray6")!
        static let gray7 = UIColor(named: "gray7")!
        static let gray8 = UIColor(named: "gray8")!
        static let gray9 = UIColor(named: "gray9")!

    }
    
    
}


enum Texts {
    enum Placeholder {
        static let memoTextViewPlaceholer = "내용"
    }
}




