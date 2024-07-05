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
        validateTitleText()
    }
    
    // MARK: - Method
    private func validateTitleText() {
        let text = viewManager.titleTextField.text
        if !isOnlyWhitespace(text) {
            
            let realm = try! Realm()
            
            let data = TodoTable(title: text ?? "", memo: nil, expirationDate: nil, tag: nil, priority: nil, image: nil)
            
            try! realm.write {
                realm.add(data)
                print("Realm Create Succeed")
            }
            
            dismiss(animated: true)
        }
            
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
                detailText = String(priority)
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
            taskAfterReceivingData = { date in
                print("💚expirationDate💚date💚💚", date)
                guard let date = date as? Date else { return }
                self.todoData.expirationDate = date
                print("💚expirationDate💚self.todoData💚💚", self.todoData)
            }
        case .tag:
            taskAfterReceivingData = { stringArray in
                print("💚tag💚-💚💚", stringArray)
                guard let stringArray = stringArray as? [String] else { return }
                self.todoData.tag = stringArray.first
                print("💚expirationDate💚self.todoData💚💚", self.todoData)
            }
        case .priority:
            taskAfterReceivingData = { int in
                print("💚priority💚-💚💚", int)
                guard let int = int as? Int else { return }
                self.todoData.priority = int
                print("💚expirationDate💚self.todoData💚💚", self.todoData)
                
            }
        case .image:
            taskAfterReceivingData = { image in
                print("💚image💚-💚💚", image)
                
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
        if textView.text == Texts.Placeholder.memoTextViewPlaceholer {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //focus를 잃는 경우
    func textViewDidEndEditing(_ textView: UITextView) {
        if isOnlyWhitespace(textView.text){
            textView.text = Texts.Placeholder.memoTextViewPlaceholer
            textView.textColor = .lightGray
        }
    }
}


// TODO: - 제목 textField 입력할 때마다 validate -> 네비게이션에 있는 버튼 활성화 or not




