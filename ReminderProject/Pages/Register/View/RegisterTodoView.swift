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
    private let textFieldBackgroundView = {
        let view = UIView()
        view.backgroundColor = Assets.Color.gray2
        view.layer.cornerRadius = 15
//        view.clipsToBounds = true
        return view
    }()
    
    
     let titleTextField = {
        let tf = UITextField()
        tf.normalTextField()
        tf.configurePlaceholderColor("제목")
        return tf
    }()
    
    private let separator = Separator()
    
    lazy var memoTextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.text = memoTextViewPlaceholer
        tv.textColor = Assets.Color.gray3
        tv.font = .systemFont(ofSize: 16)
        return tv
    }()
    
    let editItemsTableView = {
        let tv = AutoResizingTableView()
        tv.rowHeight = 50
        tv.backgroundColor = .clear
        return tv
    }()
    
    let photoImageView = {
        let iv = UIImageView()
        iv.configureDefaultImageView(bgColor: .clear)
        return iv
    }()

    // MARK: - Properties
    let memoTextViewPlaceholer = Constants.Placeholder.memoTextViewPlaceholer

    
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
        [textFieldBackgroundView, titleTextField, separator, memoTextView, editItemsTableView, photoImageView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        textFieldBackgroundView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(memoTextView.snp.bottom)
//            make.height.equalTo(160)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(textFieldBackgroundView.snp.top).offset(4)
            make.horizontalEdges.equalTo(textFieldBackgroundView).inset(8)
            make.height.equalTo(40)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.equalTo(textFieldBackgroundView).inset(8)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom)
            make.horizontalEdges.equalTo(textFieldBackgroundView).inset(8)
            make.height.equalTo(120)
        }
        
        editItemsTableView.snp.makeConstraints { make in
            make.top.equalTo(memoTextView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(10)
//            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(editItemsTableView.snp.bottom).offset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(100)
        }
    }

}


