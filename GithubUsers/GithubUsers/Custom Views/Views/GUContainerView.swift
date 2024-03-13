//
//  GUContainerView.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import UIKit

class GUContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom Configuration
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor     = .systemBackground
        layer.cornerRadius  = 15
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
    }
    
}
