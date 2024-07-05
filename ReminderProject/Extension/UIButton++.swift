//
//  UIButton++.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit

extension UIButton {
    func normalButton(title : String, bgColor : UIColor = Assets.Color.blue3) {
        self.layer.cornerRadius = 10
        self.backgroundColor = bgColor
        self.setTitleColor(Assets.Color.white, for: .normal)
        self.setTitle(title, for: .normal)
    }
    
    
}
