//
//  AddFolderViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/8/24.
//

import UIKit
import RealmSwift

final class AddFolderViewController : UIViewController {
    // MARK: - UI
    private let viewManager = AddFolderView()
    // MARK: - Properties
    private let repository = RealmDBRepository()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarButton()
    }
    
    // MARK: - setupNavigationBar
    func configureNavigationBarButton() {
        let save = UIBarButtonItem(title : "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        navigationItem.rightBarButtonItems = [save]
    }
    
    // MARK: - SetupDelegate
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    // MARK: - EventSelector
    @objc private func saveButtonClicked() {
        guard let name = viewManager.nameTextField.text,
              let detail = viewManager.detailTextField.text else {
                  return
              }
        let folderData = TodoFolder(name: name, detail: detail, regDate: Date())
        repository.createItem(folderData)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}
