//
//  TodoListTableViewCell.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit
import SnapKit

final class TodoListTableViewCell : UITableViewCell {
    // MARK: - UI
    let checkToggleButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "circle"), for: .normal) //checkmark.circle.fill
        btn.tintColor = Assets.Color.gray4
        return btn
    }()
    
    private let priorityLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = Assets.Color.blue1
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = Assets.Color.white
        label.numberOfLines = 1
        return label
    }()
    
    private let memoLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = Assets.Color.gray4
        label.numberOfLines = 1
        return label
    }()
    
    private let expriationDateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = Assets.Color.gray4
        return label
    }()
    
    private let tagsLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = Assets.Color.blue3
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : TodoTable) {
        titleLabel.text = data.title
    
        checkToggleButton.setImage(UIImage(systemName: data.isCompleted ? "checkmark.circle.fill" : "circle"), for: .normal)
        
        if let priority = data.priority {
            let numberOfExclamationMark = Constants.PrioritySegmentItem(rawValue : priority)!.numberOfExclamationMark
            priorityLabel.text = String(repeating: "!", count: numberOfExclamationMark)
          
        } else { priorityLabel.text = "" }
        
        if let memo = data.memo {
            memoLabel.text = memo
        } else {  memoLabel.text = "" }
        
        if let date = data.expirationDate {
            let dateString = DateFormatter.getDateFormatter(format: .yearDotMonthDotDay).string(from: date)
            expriationDateLabel.text = dateString
        } else {expriationDateLabel.text =  "" }
        
        if let tag = data.tag {
            tagsLabel.text = "#\(tag)"
        }else { tagsLabel.text = "" }
    }

    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [checkToggleButton, priorityLabel, titleLabel, memoLabel, expriationDateLabel, tagsLabel]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        
        checkToggleButton.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).offset(10)
            make.size.equalTo(30)
        }
        
        priorityLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(checkToggleButton.snp.trailing).offset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalTo(priorityLabel.snp.trailing).offset(4)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(checkToggleButton.snp.trailing).offset(10)
        }
        
        expriationDateLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(4)
            make.leading.equalTo(checkToggleButton.snp.trailing).offset(10)
        }
        
        tagsLabel.snp.makeConstraints { make in
            make.top.equalTo(memoLabel.snp.bottom).offset(4)
            make.leading.equalTo(expriationDateLabel.snp.trailing).offset(4)
        }
        
        
    }

    
    
    
}
