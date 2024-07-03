//
//  TodoListViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit


final class TodoListViewController : UIViewController {
    // MARK: - UI
    let viewManager = TodoListView()
    // MARK: - Properties
    // MARK: - Lifecycle
    
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationTitle(title: "목록", color: .white)
        configureNavigationBarButton()
    }
    // MARK: - setupNavigationBar
    func configureNavigationBarButton() {
        let plus = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(plusButtonClicked))
        navigationItem.rightBarButtonItems = [plus]
    }
    
    // MARK: - SetupDelegate
    
    
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    @objc private func plusButtonClicked() {
        pageTransition(to: RegisterTodoViewController.self, type: .presentNavigation)
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
    
}
