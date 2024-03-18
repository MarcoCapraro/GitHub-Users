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
    convenience init(backgroundColor: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(color: backgroundColor, title: title, systemImageName: systemImageName)
    }
    
    // This is needed to avoid storyboard initialization error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configuration                               = .filled()
        configuration?.cornerStyle                  = .medium
        translatesAutoresizingMaskIntoConstraints   = false
    }
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor  = color
        configuration?.baseForegroundColor  = .white
        configuration?.title                = title
        
        configuration?.image                = UIImage(systemName: systemImageName)
        configuration?.imagePadding         = 6
        configuration?.imagePlacement       = .leading
    }
}

#Preview {
    GUButton(backgroundColor: .blue, title: "Test Button", systemImageName: "pencil")
}
