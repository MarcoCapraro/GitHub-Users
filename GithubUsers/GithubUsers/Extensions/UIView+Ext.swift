//
//  UIView+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/14/24.
//

import UIKit

extension UIView {
    
    // Variadic Parameter that allows us to input any amount of views, that it will convert to an array
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
