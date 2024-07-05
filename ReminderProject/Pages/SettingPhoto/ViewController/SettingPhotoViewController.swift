//
//  SettingPhotoViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit


final class SettingPhotoViewController : UIViewController, PassDataDelegatePropertyProtocol {
    // MARK: - Properties
    var delegate: ObserveDataDelegate?
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let delegate else {return }
        delegate.observeNextPageData(data: "포토포토")
    }
}

