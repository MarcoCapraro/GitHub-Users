//
//  UIView+Ext.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/14/24.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
        ])
        
    }
    
    // Variadic Parameter that allows us to input any amount of views, that it will convert to an array
    func addSubViews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
