//
//  TodoMainViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit


final class TodoMainViewController : UIViewController {
    // MARK: - UI
    let viewManager = TodoMainView()
    
    // MARK: - Properties
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
    }
    
    // MARK: - SetupDelegate
    
    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.addTodoButton.addTarget(self, action: #selector(addTodoButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - EventSelector
    @objc private func addTodoButtonTapped() {
        let vc = RegisterTodoViewController()
        pageTransition(to: vc, type: .presentNavigation)
    }
    
    // MARK: - APIFetch
    // MARK: - PageTransition
    
    
}
