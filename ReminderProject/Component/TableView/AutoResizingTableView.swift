//
//  AutoResizingTableView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/6/24.
//

import UIKit


class AutoResizingTableView : UITableView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
}
