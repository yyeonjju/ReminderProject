//
//  EditItemsTableViewCell.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import SnapKit


final class EditItemsTableViewCell : UITableViewCell {
    // MARK: - UI
    private let background = {
        let view = UIView()
        view.backgroundColor = Assets.Color.gray2
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    
    private let detailLabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private let chevronImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.right")
        iv.tintColor = .white
        return iv
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureSubView()
        configureLayout()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : TodoEditItem) {
        titleLabel.text = data.rawValue
//        detailLabel.text = "999"
    }
    

    
    // MARK: - ConfigureUI
    private func configureUI() {
        backgroundColor = .clear
    }
    
    
    private func configureSubView() {
        [background]
            .forEach{
                contentView.addSubview($0)
            }
        [titleLabel, detailLabel, chevronImageView]
            .forEach{
                background.addSubview($0)
            }
    }
    
    private func configureLayout() {
        
        background.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.verticalEdges.equalTo(contentView).inset(5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView).offset(5)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).inset(5)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chevronImageView.snp.leading)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }

}
