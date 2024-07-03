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
    let label = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "전체"
        return label
    }()
    
    let todoListTableView = {
        let tv = UITableView()
        
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
        [todoListTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    func configureLayout() {
        
    }

}
