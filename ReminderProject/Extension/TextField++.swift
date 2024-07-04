//
//  TextField++.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit

extension UITextField {
    func normalTextField(bgColor : UIColor = .clear) {
        self.backgroundColor = bgColor
        self.layer.cornerRadius = 10
    }
    
    func configurePlaceholderColor(_ placeholder: String, _ color : UIColor = Assets.Color.gray3) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : color])
    }
}
