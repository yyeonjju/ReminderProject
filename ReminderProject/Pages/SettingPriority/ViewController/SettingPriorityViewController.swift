//
//  SettingPriorityViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit


final class SettingPriorityViewController : UIViewController, PassDataDelegatePropertyProtocol {
    // MARK: - UI
    let viewManager = SettingPriorityView()

    // MARK: - Properties
    var delegate: ObserveDataDelegate?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewManager.prioritySegmentControl.selectedSegmentIndex = 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let delegate else {return }
        let selectedIndex = viewManager.prioritySegmentControl.selectedSegmentIndex
        delegate.observeNextPageData(data: selectedIndex)
    }

    // MARK: - SetupDelegate
    // MARK: - AddTarget
    // MARK: - EventSelector
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}

