//
//  RegisterTodoViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit
import RealmSwift

final class RegisterTodoViewController : UIViewController {
    
    // MARK: - UI
    let viewManager = RegisterTodoView()
    
    // MARK: - Properties
    let todoEditItemList = TodoEditItem.allCases
    var taskAfterReceivingData : (Any) -> Void = {_ in }
    let todoData = TodoTable()
    let repository = RealmDBRepository()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationTitle(title: "새로운 할 일", color: .white)
        configureNavigationBarButton()
        setupDelegate()
    }
    
    // MARK: - setupNavigationBar
    func configureNavigationBarButton() {
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelBarButtonClicked))
        let add = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addBarButtonClicked))
        navigationItem.leftBarButtonItems = [cancel]
        navigationItem.rightBarButtonItems = [add]
    }

    
    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.memoTextView.delegate = self
        
        viewManager.editItemsTableView.dataSource = self
        viewManager.editItemsTableView.delegate = self
        viewManager.editItemsTableView.register(EditItemsTableViewCell.self, forCellReuseIdentifier: EditItemsTableViewCell.description())
    }
    // MARK: - AddTarget
    private func setupAddTarget() {
    }
    
    // MARK: - EventSelector
    @objc private func cancelBarButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc private func addBarButtonClicked() {
        if validateTitleText() {
            
            //1. realm DB에 저장
            let data = todoData
            data.title = viewManager.titleTextField.text!
            data.memo = viewManager.memoTextView.text
            data.registerDate = Date()
            repository.createItem(data)

            //2. 이미지를 fileManager에 저장
            if let image = viewManager.photoImageView.image {
                ImageSavingManager.saveImageToDocument(image: image, filename: "\(data.id)")
            }

            dismiss(animated: true)
        }
        
    }
    
    // MARK: - Method
    private func validateTitleText() -> Bool {
        let text = viewManager.titleTextField.text
        return !isOnlyWhitespace(text)
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}

extension RegisterTodoViewController : UITableViewDelegate, UITableViewDataSource, ObserveDataDelegate {

    func observeNextPageData(data: Any) {
        taskAfterReceivingData(data)
        viewManager.editItemsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoEditItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EditItemsTableViewCell.description(), for: indexPath) as! EditItemsTableViewCell
        cell.selectionStyle = .none
        let data = todoEditItemList[indexPath.row]
        var detailText = ""
        switch data {
        case .expirationDate:
            if let expirationDate = todoData.expirationDate {
                detailText = DateFormatter.getDateFormatter(format: .yearDotMonthDotDay).string(from: expirationDate)
            }
        case .tag:
            if let tag = todoData.tag {
                detailText = tag
            }
        case .priority:
            if let priority = todoData.priority {
                detailText = Constants.PrioritySegmentItem(rawValue: priority)?.itemText ?? "--"
            }
        case .image:
            detailText = ""
        }
        
        cell.configureData(data : data, detailText : detailText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = todoEditItemList[indexPath.row]
        
        switch data {
        case .expirationDate:
            taskAfterReceivingData = { [weak self] date in
                guard let self, let date = date as? Date else { return }
                self.todoData.expirationDate = date
            }
        case .tag:
            taskAfterReceivingData = { [weak self] stringArray in
                guard let self, let stringArray = stringArray as? [String] else { return }
                self.todoData.tag = stringArray.first
            }
        case .priority:
            taskAfterReceivingData = { [weak self] int in
                guard let self, let int = int as? Int else { return }
                self.todoData.priority = int
            }
        case .image:
            taskAfterReceivingData = { [weak self] uiImage in
                guard let self else { return }
                self.viewManager.photoImageView.image = uiImage as? UIImage
            }
        }
        
        
        let vc = data.pushTo.init() as? UIViewController&PassDataDelegatePropertyProtocol
        guard let vc else {return }
        vc.delegate = self
        pageTransition(to: vc, type: .push)
    }
}


extension RegisterTodoViewController : UITextViewDelegate {
    //focus를 얻는 경우
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.Placeholder.memoTextViewPlaceholer {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //focus를 잃는 경우
    func textViewDidEndEditing(_ textView: UITextView) {
        if isOnlyWhitespace(textView.text){
            textView.text = Constants.Placeholder.memoTextViewPlaceholer
            textView.textColor = .lightGray
        }
    }
}




