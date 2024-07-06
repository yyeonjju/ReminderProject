//
//  SettingPhotoView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/6/24.
//

import UIKit
import SnapKit

final class SettingPhotoView : BaseView {
    // MARK: - UI
    let photoImageView = {
        let iv = UIImageView()
        iv.configureDefaultImageView()
        return iv
    }()
    
    private let cameraIconView : UIView = {
        let view = UIView()
        view.backgroundColor = Assets.Color.blue3
        view.layer.borderColor = .none
        return view
    }()
    
    let cameraIconButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        btn.tintColor = Assets.Color.white
        return btn
    }()
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cameraIconView.layer.cornerRadius = cameraIconView.frame.width/2
    }

    
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
        [photoImageView, cameraIconView]
            .forEach{
                addSubview($0)
            }
        [cameraIconButton]
            .forEach {
                cameraIconView.addSubview($0)
            }
    }
    
    override func configureLayout() {
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        
        cameraIconView.snp.makeConstraints { make in
            make.size.equalTo(35)
            make.centerX.equalTo(photoImageView.snp.trailing).inset(10)
            make.centerY.equalTo(photoImageView.snp.bottom).inset(10)
        }
        
        cameraIconButton.snp.makeConstraints { make in
            make.size.equalTo(25)
            make.center.equalToSuperview()
        }
    }

}
