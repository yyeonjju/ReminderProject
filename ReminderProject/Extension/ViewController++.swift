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
    
    func pageTransition<T : UIViewController>(to viewController : T.Type, type : TransitionType) {
        let vc = viewController.self.init()
        
        switch type {
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
        
    }
    
    
    func configureNavigationTitle(title : String, color : UIColor) {
        navigationItem.title = title
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: color]
    }
    
    
}

