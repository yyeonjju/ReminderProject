//
//  SettingTagView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit
import SnapKit

final class SettingTagView : BaseView {
    // MARK: - UI
    let tagTextField = {
        let tf = UITextField()
        tf.normalTextField(bgColor: Assets.Color.gray3)
        tf.placeholder = "태그 입력"
        return tf
    }()
    
    let addTagButton = {
        let btn = UIButton()
        btn.normalButton(title: "등록")
        return btn
    }()
    
    let tagsCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout )
        cv.backgroundColor = .clear
        return cv
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
        [tagTextField, addTagButton, tagsCollectionView]
            .forEach{
                addSubview($0)
            }
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(addTagButton.snp.leading).offset(-10)
            make.height.equalTo(50)
        }
        
        addTagButton.snp.makeConstraints { make in
            make.centerY.equalTo(tagTextField)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(30)
            make.width.equalTo(60)
        }
        
        tagsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tagTextField.snp.bottom).offset(30)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }

}
