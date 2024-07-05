//
//  SettingDateView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit
import FSCalendar


final class SettingDateView : BaseView {
    // MARK: - UI
    let calendarDateLabel : UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = Assets.Color.gray3
        return label
    }()
    
    // 이전 달 이동 버튼
    lazy var previousButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = Assets.Color.gray3
        return button
    }()
    // 다음 달 이동 버튼
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = Assets.Color.gray3
        return button
    }()
    
    let calendar : FSCalendar = {
        let calendar = FSCalendar()
        //단위
        calendar.scope = .month
        calendar.headerHeight = 0
        calendar.scrollEnabled = false
        
        // 기본 설정
        calendar.placeholderType = .none // 현재 달의 날짜만 표시
        
        //요일 라벨
        calendar.weekdayHeight = 20
        calendar.appearance.weekdayFont = .boldSystemFont(ofSize: 15)
        calendar.appearance.weekdayTextColor = Assets.Color.gray3
        
        //날짜 라벨
        calendar.appearance.titleDefaultColor = Assets.Color.gray5
        calendar.appearance.selectionColor = Assets.Color.blue3
        calendar.appearance.titleTodayColor = .red //오늘 점 표시(없앰)
        calendar.appearance.todayColor = .clear

        //언어
        calendar.locale = Locale(identifier: "ko_KR") // 월~일
        
        return calendar
    }()
    
    
    // MARK: - Initializer
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureBackgroundColor(color: Assets.Color.gray1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [calendarDateLabel, previousButton, nextButton, calendar]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        calendarDateLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        previousButton.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.centerY.equalTo(calendarDateLabel.snp.centerY)
            make.size.equalTo(30)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.centerY.equalTo(calendarDateLabel.snp.centerY)
            make.size.equalTo(30)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(calendarDateLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(300)
        }
    }

}
