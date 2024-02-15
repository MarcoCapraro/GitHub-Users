//
//  UIViewController+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import UIKit

extension UIViewController {
    
    func presentGUAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GUAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            
            self.present(alertVC, animated: true)
        }
    }
}
