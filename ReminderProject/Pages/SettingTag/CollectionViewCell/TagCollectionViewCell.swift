//
//  TagCollectionViewCell.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit
import SnapKit

final class TagCollectionViewCell : UICollectionViewCell {
    // MARK: - UI
    private let tagLabel = {
        let label = UILabel()
        label.backgroundColor = Assets.Color.white
        label.textColor = Assets.Color.gray2
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let deleteButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        btn.tintColor = Assets.Color.gray6
        btn.backgroundColor = Assets.Color.black
        return btn
    }()
    
    // MARK: - Properties
    var deleteTag : (() -> Void)?
    
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tagLabel.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height)
        }
        
        deleteButton.layer.cornerRadius = deleteButton.frame.width/2
    }
    
    
    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        configureSubView()
        configureLayout()
        setupAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupAddTarget
    private func setupAddTarget() {
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - EventSelector
    @objc private func deleteButtonTapped() {
        deleteTag?()
    }
    
    // MARK: - ConfigureData
    func configureData(text : String) {
        tagLabel.text = "  #\(text)   "
    }

    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [tagLabel, deleteButton]
            .forEach{
                contentView.addSubview($0)
            }
    }
    
    private func configureLayout() {
        tagLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerX.equalTo(tagLabel.snp.trailing)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
    }

}
