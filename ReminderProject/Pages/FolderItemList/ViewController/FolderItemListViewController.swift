//
//  FolderItemListViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/8/24.
//

import UIKit
import RealmSwift


final class FolderItemListViewController : TodoListViewController {
    // MARK: - UI
    
    // MARK: - Properties
    var folder : TodoFolder?
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let folder else {return }
        configureNavigationTitle(title: folder.name, color: Assets.Color.white)
        
        //List를 Result로 바꿈.. -> 전반적으로 수정을 해야하나..
        list = repository.getResultsFromList(list: folder.relatedList)
        
        viewManager.subjectLabel.isHidden = true
        
    }
    

}
