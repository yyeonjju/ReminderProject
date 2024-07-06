//
//  SettingPhotoViewController.swift
//  ReminderProject
//
//  Created by 하연주 on 7/5/24.
//

import UIKit
import PhotosUI


final class SettingPhotoViewController : UIViewController, PassDataDelegatePropertyProtocol {
    
    // MARK: - UI
    let viewManager = SettingPhotoView()
    
    // MARK: - Properties
    var delegate: ObserveDataDelegate?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        view = viewManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddTarget()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard let delegate else {return }
        delegate.observeNextPageData(data: viewManager.photoImageView.image)
    }
    
    // MARK: - SetupDelegate
    // MARK: - AddTarget
    private func setupAddTarget() {
        viewManager.cameraIconButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - EventSelector
    @objc private func cameraButtonTapped () {
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        config.filter = .any(of: [.images])
    
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        pageTransition(to: picker, type: .present)
    }
    
    // MARK: - SetupUI
    // MARK: - APIFetch
    // MARK: - PageTransition
}


extension SettingPhotoViewController : PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider // 2
        
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) { // 3
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in // 4
                guard let self, let image else { return }
                
                DispatchQueue.main.async {
                    self.viewManager.photoImageView.image = image as? UIImage
                }
            }
        } else {
            // TODO: Handle empty results or item provider not being able load UIImage
        }
        
    }
}
