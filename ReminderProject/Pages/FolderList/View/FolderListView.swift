//
//  FolderListView.swift
//  ReminderProject
//
//  Created by 하연주 on 7/8/24.
//

import UIKit
import SnapKit

final class FolderListView : BaseView {
    // MARK: - UI
    let foldersTableView = {
        let tv = UITableView()
        tv.rowHeight = 50
        tv.backgroundColor = .clear
        return tv
    }()
    
    
    // MARK: - ConfigureUI
    
    override func configureSubView() {
        [foldersTableView]
            .forEach{
                addSubview($0)
  
            }
    }
    
    override func configureLayout() {
        foldersTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }

}
