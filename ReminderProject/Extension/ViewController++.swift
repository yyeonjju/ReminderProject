//
//  ViewController++.swift
//  ReminderProject
//
//  Created by 하연주 on 7/3/24.
//

import UIKit

extension UIViewController {
    enum TransitionType {
        case push
        case present
        case presentNavigation
        case presentFullNavigation
    }
    
    func pageTransition(to viewController : UIViewController, type : TransitionType) {
        switch type {
        case .push:
            navigationController?.pushViewController(viewController, animated: true)
        case .present:
            present(viewController, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
        
    }
    
    
    func configureNavigationTitle(title : String, color : UIColor) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    
    
}

