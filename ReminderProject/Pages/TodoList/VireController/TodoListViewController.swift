//
//  TodoListViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import RealmSwift


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
        
        let realm = try! Realm()
        print(realm.configuration.fileURL)
        let value = realm.objects(TodoTable.self)
        print("🧡value🧡", value)
        
        
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
