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
    var list : Results<TodoTable>! {
        didSet{
            viewManager.todoListTableView.reloadData()
        }
    }
    let repository = RealmDBRepository()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let value = repository.getAllObjects(tableModel: TodoTable.self)
        list = value
        print("list --> ", list)
        
        configureNavigationTitle(title: "목록", color: .white)
        configureNavigationBarButton()
        setupDelegate()
    }
    // MARK: - setupNavigationBar
    func configureNavigationBarButton() {
        let plus = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(plusButtonClicked))
        navigationItem.rightBarButtonItems = [plus]
    }
    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.todoListTableView.dataSource = self
        viewManager.todoListTableView.delegate = self
        viewManager.todoListTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.description())
    }
    
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    @objc private func plusButtonClicked() {
        let vc = RegisterTodoViewController()
        pageTransition(to: vc, type: .presentNavigation)
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
    
}


extension TodoListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.description(), for: indexPath) as! TodoListTableViewCell
        let data = list[indexPath.row]
        cell.configureData(data : data)
        return cell
    }
}
