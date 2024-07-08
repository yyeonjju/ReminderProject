//
//  FoldersTableViewCell.swift
//  ReminderProject
//
//  Created by 하연주 on 7/8/24.
//

import UIKit
import SnapKit


final class FoldersTableViewCell : UITableViewCell {
    // MARK: - UI
    let containerView = {
        let view = UIView()
        view.backgroundColor = Assets.Color.gray2
        view.layer.opacity = 0.8
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    let chevronImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = Assets.Color.gray6
        return iv
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSubView()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - ConfigureUI
    
    func configureSubView() {
        [containerView, chevronImageView]
            .forEach{
                contentView.addSubview($0)
             
            }
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(2)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(16)
            make.trailing.equalTo(contentView).inset(10)
        }
    }

}
