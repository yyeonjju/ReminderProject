//
//  SettingPriorityView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/6/24.
//

import UIKit
import SnapKit


final class SettingPriorityView : BaseView {
    // MARK: - UI
    let prioritySegmentControl = {
        let segmentItem = Constants.PrioritySegmentItem.allCases.map{$0.itemText}
        let sc = UISegmentedControl(items: segmentItem)
        sc.backgroundColor = Assets.Color.blue3
        sc.selectedSegmentTintColor = Assets.Color.blue1
        return sc
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
        [prioritySegmentControl]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        prioritySegmentControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
    }

}
