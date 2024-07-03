//
//  TextField++.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit

extension UITextField {
    func normalTextField() {
        self.backgroundColor = .gray
        self.layer.cornerRadius = 10
    }
    
    func configurePlaceholderColor(_ placeholder: String, _ color : UIColor = .systemGray3) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : color])
    }
}
