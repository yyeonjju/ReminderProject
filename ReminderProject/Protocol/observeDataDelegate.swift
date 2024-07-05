//
//  observeDataDelegate.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import Foundation

protocol ObserveDataDelegate : AnyObject{
    func observeNextPageData(data : Any) -> Void
}

protocol PassDataDelegatePropertyProtocol : AnyObject {
    var delegate : ObserveDataDelegate? {get set}
}


