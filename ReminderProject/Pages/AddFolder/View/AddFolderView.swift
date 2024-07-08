//
//  AddFolderView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/8/24.
//

import UIKit
import SnapKit

final class AddFolderView : BaseView {
    // MARK: - UI
    let nameTextField = {
        let tf = UITextField()
        tf.normalTextField(bgColor: Assets.Color.gray3)
        tf.configurePlaceholderColor("폴더 이름", Assets.Color.white)
        return tf
    }()
    
    let detailTextField = {
        let tf = UITextField()
        tf.normalTextField(bgColor: Assets.Color.gray3)
        tf.configurePlaceholderColor("폴더 내용", Assets.Color.white)
        return tf
    }()
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [nameTextField, detailTextField]
            .forEach{
                addSubview($0)
                
            }
    }
    
    override func configureLayout() {
        nameTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
        
        detailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            make.height.equalTo(40)
        }
    }

}
