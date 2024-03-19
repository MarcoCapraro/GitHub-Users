//
//  UIViewController+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentGUAlert(alertTitle: String, message: String, buttonTitle: String) {
        let alertVC                     = GUAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        
        self.present(alertVC, animated: true)
    }
    
    func presentDefaultAlert() {
        let alertVC                     = GUAlertVC(alertTitle: "Something Went Wrong",
                                                    message: "We were unable to complete your task at this time. Please try again.",
                                                    buttonTitle: "Ok")
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        
        self.present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
}
