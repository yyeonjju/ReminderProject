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

        repository.checkSchemaVersion()
        
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
        cell.selectionStyle = .none
        let data = list[indexPath.row]
        cell.configureData(data : data)
        cell.checkToggleButton.tag = indexPath.row
        cell.checkToggleButton.addTarget(self, action: #selector(checkToggleButtonTapped), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list[indexPath.row]
        
        let delete = UIContextualAction(style: .normal, title: "delete") {action, view, completionHandler in
            self.repository.removeItem(data)
            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
        }
        delete.backgroundColor = Assets.Color.red
        
        let flag = UIContextualAction(style: .normal, title: "flag") {action, view, completionHandler in
            let value = !data.isFlaged
            //realm 데이터 업데이트
            self.repository.editItem(TodoTable.self, at: data.id, editKey: TodoTableProperty.isFlaged.rawValue, to: value)

            //테이블뷰 업데이트
            self.viewManager.todoListTableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        flag.backgroundColor = Assets.Color.flagYellow
        
        return UISwipeActionsConfiguration(actions: [flag, delete])
    }
    
    
    
    @objc private func checkToggleButtonTapped(button : UIButton) {
        let index = button.tag
        let data = list[index]
        let value = !data.isCompleted
        //realm 데이터 업데이트
        repository.editItem(TodoTable.self, at: data.id, editKey: TodoTableProperty.isCompleted.rawValue, to: value)

        //테이블뷰 업데이트
        viewManager.todoListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
