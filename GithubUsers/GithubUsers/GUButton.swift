//
//  GUButton.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/13/24.
//

import UIKit

class GUButton: UIButton {

    // Need to override for custom configurations
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom Configurations
        configure()
    }
    
    // To create buttons with different text and color
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    // This is needed to avoid storyboard initialization error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        
        // Human Interface Guidelines recommended using built-in text styles for dynamic type and consistency
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
