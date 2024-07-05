//
//  SettingTagViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit


final class SettingTagViewController : UIViewController, PassDataDelegatePropertyProtocol {
    
    // MARK: - UI
    let viewManager = SettingTagView()

    
    // MARK: - Properties
    var delegate: ObserveDataDelegate?
    var tagList : [String] = [] {
        didSet{
            viewManager.tagsCollectionView.reloadData()
        }

    }
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupAddTarget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        guard let delegate else {return }
        delegate.observeNextPageData(data:tagList)
    }
    

    // MARK: - SetupDelegate
    private func setupDelegate() {
        viewManager.tagsCollectionView.dataSource = self
        viewManager.tagsCollectionView.delegate = self
        viewManager.tagsCollectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.description())
    }
    
    
    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.addTagButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
    }
    // MARK: - EventSelector
    @objc private func addButtonTapped() {
        let text = viewManager.tagTextField.text
        guard let text else {return }
        if !isOnlyWhitespace(text) {
            tagList.append(text)
        }
        viewManager.tagTextField.text = ""

    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}


extension SettingTagViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.description(), for: indexPath) as! TagCollectionViewCell
        let data = tagList[indexPath.row]
        cell.configureData(text: data)
        cell.deleteTag = {[weak self] in
            guard let self else{return }
            self.tagList.remove(at: indexPath.row)
        }
        return cell
    }
    
}

extension SettingTagViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let label = UILabel(frame: CGRect.zero)
            label.text = tagList[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 30, height: 30)
        }
}
