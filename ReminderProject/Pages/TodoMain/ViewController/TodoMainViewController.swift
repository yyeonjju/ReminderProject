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
    let categoryItems = CategoryItem.allCases
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupAddTarget()
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
        pageTransition(to: vc, type: .presentNavigation)
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
        let data = categoryItems[indexPath.row]
        cell.configureData(data: data)
        return cell
    }
}
