//
//  NameSpace.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import RealmSwift

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

enum CategoryItem : String, CaseIterable {
    case today = "오늘"
    case upcoming = "예정"
    case all = "전체"
    case flag = "깃발 표시"
    case completed = "완료됨"
    
    struct iconStyle {
        let systemName : String
        let color : UIColor
    }
    
    var icon : iconStyle {
        switch self {
        case .today:
            iconStyle(systemName: "clock", color: Assets.Color.blue2)
        case .upcoming:
            iconStyle(systemName: "calendar", color: Assets.Color.red)
        case .all:
            iconStyle(systemName: "tray", color: Assets.Color.gray3)
        case .flag:
            iconStyle(systemName: "flag.fill", color: Assets.Color.flagYellow)
        case .completed:
            iconStyle(systemName: "checkmark", color: Assets.Color.gray3)
        }
    }
    
    func todoList (wholeList : Results<TodoTable>) -> Results<TodoTable> {
        switch self {
        case .today:
            wholeList.where{$0.expirationDate.contains(returnTodayDateRange(for: Date()))}
        case .upcoming:
            wholeList.where{$0.expirationDate > Date()}
        case .all:
            wholeList
        case .flag:
            wholeList.where{$0.isFlaged}
        case .completed:
            wholeList.where{$0.isCompleted}
        }
    }
}



enum Assets {
    enum Color {
        static let black = UIColor(named: "black")!
        
        static let white = UIColor(named: "white")!
        
        static let flagYellow = UIColor(named: "flagYellow")!
        static let red = UIColor(named: "red")!
        
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


enum Constants {
    enum Placeholder {
        static let memoTextViewPlaceholer = "내용"
    }
    
    enum PrioritySegmentItem : Int, CaseIterable  {
        case high
        case moderate
        case low
        
        
        var itemText : String {
            switch self {
            case .high:
                return "높음"
            case .moderate:
                return "보통"
            case .low:
                return "낮음"
            }
        }
        
        var numberOfExclamationMark : Int {
            -(self.rawValue - 3)
        }
        
    }
    
}




