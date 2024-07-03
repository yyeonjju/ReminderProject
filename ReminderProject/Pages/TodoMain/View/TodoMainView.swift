//
//  TodoMainView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import SnapKit

final class TodoMainView : BaseView {
    // MARK: - UI
    private let label = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .lightGray
        label.text = "전체"
        return label
    }()
    
    let addTodoButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.setTitle("새로운 할 일", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    
    // MARK: - Initializer
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [label, addTodoButton]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide)
        }
        
        addTodoButton.snp.makeConstraints { make in
            make.bottom.leading.equalTo(safeAreaLayoutGuide)
            
        }
    }

}
