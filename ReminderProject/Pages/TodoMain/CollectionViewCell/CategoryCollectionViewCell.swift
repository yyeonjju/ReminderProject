//
//  CategoryCollectionViewCell.swift
//  ReminderProject
//
//  Created by 하연주 on 7/6/24.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell : UICollectionViewCell {
    // MARK: - UI
    let containerView = {
        let view = UIView()
        view.backgroundColor = Assets.Color.gray1
        view.layer.opacity = 0.8
        view.layer.cornerRadius = 12
        return view
    }()
    
    let iconContainerView = {
        let view = UIView()
        return view
    }()
    
    let iconImage = {
        let iv = UIImageView()
        iv.tintColor = Assets.Color.white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let categoryTitleLabel = {
       let label = UILabel()
        label.textColor = Assets.Color.gray5
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    let countLabel = {
       let label = UILabel()
        label.textColor = Assets.Color.white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - Lifecycle
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        iconContainerView.layer.cornerRadius = iconContainerView.bounds.width/2
    }

    // MARK: - Initializer
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        configureSubView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ConfigureData
    func configureData(data : CategoryItem) {
        iconImage.image = UIImage(systemName: data.icon.systemName)
        iconContainerView.backgroundColor = data.icon.color
        categoryTitleLabel.text = data.rawValue
        countLabel.text = "\(0)"
    }
    
    
    // MARK: - ConfigureUI
    
    private func configureSubView() {
        [containerView, iconContainerView, categoryTitleLabel, countLabel]
            .forEach{
                contentView.addSubview($0)
            }
        iconContainerView.addSubview(iconImage)
    }
    
    private func configureLayout() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        iconContainerView.snp.makeConstraints { make in
            make.top.leading.equalTo(containerView).offset(10)
            make.size.equalTo(28)
        }
        iconImage.snp.makeConstraints { make in
            make.center.equalTo(iconContainerView)
            make.size.equalTo(20)
        }
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconContainerView.snp.bottom).offset(8)
            make.leading.equalTo(iconContainerView).offset(4)
        }
        
        countLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(containerView).inset(10)
        }
        
    }

}
