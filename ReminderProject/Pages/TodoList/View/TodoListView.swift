//
//  TodoListView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import SnapKit

final class TodoListView : UIView {
    // MARK: - UI
    let subjectLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .systemBlue
        return label
    }()
    
    let todoListTableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.rowHeight = 80
        return tv
    }()
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    func configureSubView() {
        [subjectLabel, todoListTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    func configureLayout() {
        subjectLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide)
        }
        todoListTableView.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

}
