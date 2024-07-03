//
//  RegisterTodoView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import SnapKit

final class RegisterTodoView : BaseView {
    // MARK: - UI
     let titleTextField = {
        let tf = UITextField()
        tf.normalTextField()
        tf.configurePlaceholderColor("제목")
        return tf
    }()
    
    private let memoTextField = {
        let tf = UITextField()
        tf.normalTextField()
        tf.configurePlaceholderColor("메모")
        return tf
    }()
    
    let editItemsTableView = {
        let tv = UITableView()
        tv.rowHeight = 50
        tv.backgroundColor = .clear
        return tv
    }()

    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureBackgroundColor(color: .darkGray)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [titleTextField, memoTextField, editItemsTableView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        memoTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(40)
        }
        
        editItemsTableView.snp.makeConstraints { make in
            make.top.equalTo(memoTextField.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }

}
