//
//  GUAvatarImageView.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/27/24.
//

import UIKit

class GUAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configure
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10         // rounded edges
        clipsToBounds = true            // clips avatar UIImage to bounds of UIImageView so it also conforms to rounded edges
        image = placeholderImage        // sets the default image view in case of no avatar to placeholder image
    }
}
