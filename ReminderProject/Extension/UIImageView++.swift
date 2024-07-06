//
//  UIImageView++.swift
//  ReminderProject
//
//  Created by 하연주 on 7/6/24.
//

import UIKit

extension UIImageView {
    func configureDefaultImageView(bgColor : UIColor = Assets.Color.gray3) {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
    
}
