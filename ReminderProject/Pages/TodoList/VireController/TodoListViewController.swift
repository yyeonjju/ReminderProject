//
//  TodoListViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import RealmSwift


class TodoListViewController : UIViewController {
    // MARK: - UI
    let viewManager = TodoListView()
    
    // MARK: - Properties
    var category : CategoryItem?
    var list : Results<TodoTable>!
    let repository = RealmDBRepository()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let category else {return }
        let wholeList = repository.getAllObjects(tableModel: TodoTable.self)
        filterFromWholeList(wholeList: wholeList)
        configureNavigationTitle(title: category.rawValue, color: .white)
        viewManager.subjectLabel.text = category.rawValue
        setupDelegate()
    }

    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.todoListTableView.dataSource = self
        viewManager.todoListTableView.delegate = self
        viewManager.todoListTableView.register(TodoListTableViewCell.self, forCellReuseIdentifier: TodoListTableViewCell.description())
    }
    
    // MARK: - Method
    private func filterFromWholeList(wholeList : Results<TodoTable>) {
        //데이터베이스의 리스트에서 query 적용 ->  query 적용 하면 상태값 바뀌는 순간 알아서 list 업데이트됨!!
        list = category?.todoList(wholeList: wholeList)
    }

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
            //💚 여기서도 아래와 같은 이유로 reloadRows(X) reloadData(O)
            self.viewManager.todoListTableView.reloadData()
//            tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
        flag.backgroundColor = Assets.Color.flagYellow
        
        return UISwipeActionsConfiguration(actions: [flag, delete])
    }
    
    
    
    @objc private func checkToggleButtonTapped(button : UIButton) {
//        guard let list else{return }
        let index = button.tag
        let data = list[index]
        let value = !data.isCompleted
        //realm 데이터 업데이트
        repository.editItem(TodoTable.self, at: data.id, editKey: TodoTableProperty.isCompleted.rawValue, to: value)
        

        //💚reloadRows했을 때의 문제 원인
        //list는 쿼리가 적용된 데이터베이스의 리스트!!
        // 상태값 바뀌면 =>  쿼리가 적용된대로 리스트가 자동적으로 바뀜..!
        //--> 여기서 reloadRows를 하면 자동적으로 numberOfRowsInSection 부터 또 도는데
        //reloadRows 여기서 바뀌어야하는 row는 인덱스는 3인데
        //numberOfRowsInSection에서는 이미 쿼리가 적용되어 바뀐 리스트여서 2인덱스까지밖에 없게됨
        
        //테이블뷰 업데이트
        viewManager.todoListTableView.reloadData()
//        viewManager.todoListTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
