//
//  TodoMainViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import RealmSwift


final class TodoMainViewController : UIViewController {
    // MARK: - UI
    let viewManager = TodoMainView()
    
    // MARK: - Properties
    let categoryItems = CategoryItem.allCases
    var todoList : Results<TodoTable>!
    let repository = RealmDBRepository()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarButton()
        setupDelegate()
        setupAddTarget()
        todoList = repository.getAllObjects(tableModel: TodoTable.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewManager.categoryCollectionView.reloadData()
    }
    
    // MARK: - setupNavigationBar
    func configureNavigationBarButton() {
        let folder = UIBarButtonItem(image: UIImage(systemName: "folder"), style: .plain, target: self, action: #selector(folderButtonClicked))
        folder.tintColor = Assets.Color.white
        navigationItem.rightBarButtonItems = [folder]
    }
    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.categoryCollectionView.dataSource = self
        viewManager.categoryCollectionView.delegate = self
        viewManager.categoryCollectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.description())
    }
    
    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.addTodoButton.addTarget(self, action: #selector(addTodoButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - EventSelector
    @objc private func addTodoButtonTapped() {
        let vc = RegisterTodoViewController()
        vc.taskAfterDismissing = {[weak self] in
            // present fullScreen이 아니어서 viewWillAppear 작동 X
            //추가된 데이터를CollectionView에 업데이트하기위해
            self?.viewManager.categoryCollectionView.reloadData()
        }
        pageTransition(to: vc, type: .presentNavigation)
    }
    
    @objc private func folderButtonClicked() {
        let vc = FolderListViewController()
        pageTransition(to: vc, type: .push)
    }
    
    // MARK: - APIFetch
    // MARK: - PageTransition
    
    
}


extension TodoMainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.description(), for: indexPath) as! CategoryCollectionViewCell
        let category = categoryItems[indexPath.row]
        let count = category.todoList(wholeList: todoList).count
        cell.configureData(data: category, count : count)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categoryItems[indexPath.row]
        let vc = TodoListViewController()
        vc.category = category
        pageTransition(to: vc, type: .push)
    }
}
