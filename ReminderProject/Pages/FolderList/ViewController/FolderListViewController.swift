//
//  FolderListViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/8/24.
//

import UIKit
import RealmSwift


final class FolderListViewController : UIViewController {
    // MARK: - UI
    private let viewManager = FolderListView()
    // MARK: - Properties
    private let repository = RealmDBRepository()
    private var folderList : Results<TodoFolder>!
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        configureNavigationBarButton()
        folderList = repository.getAllObjects(tableModel: TodoFolder.self)
        
        
        repository.checkSchemaVersion()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewManager.foldersTableView.reloadData()
    }
    
    // MARK: - setupNavigationBar
    func configureNavigationBarButton() {
        let addfolder = UIBarButtonItem(title : "폴더추가", style: .plain, target: self, action: #selector(addFolderButtonClicked))
        navigationItem.rightBarButtonItems = [addfolder]
    }
    
    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.foldersTableView.dataSource = self
        viewManager.foldersTableView.delegate = self
        viewManager.foldersTableView.register(FoldersTableViewCell.self, forCellReuseIdentifier: FoldersTableViewCell.description())
        
    }
    
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    @objc private func addFolderButtonClicked() {
        let vc = AddFolderViewController()
        pageTransition(to: vc, type: .push)
        
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}

extension FolderListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoldersTableViewCell.description(), for: indexPath) as! FoldersTableViewCell
        let data = folderList[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.text = data.name
        cell.textLabel?.textColor = Assets.Color.gray6
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = folderList[indexPath.row]
        let vc = FolderItemListViewController()
        vc.folder = data
        vc.category = CategoryItem.all
        pageTransition(to: vc, type: .push)
    }
}
