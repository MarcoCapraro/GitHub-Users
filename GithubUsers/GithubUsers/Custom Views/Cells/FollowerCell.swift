//
//  FollowerCell.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/27/24.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    
    static let reuseID  = "FollowerCell"
    let avatarImageView = GUAvatarImageView(frame: .zero)
    let usernameLabel   = GUTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure Custom Views Here
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        if #available(iOS 17.0, *) {
            // Passes SwiftUI View for the cell
            contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
        } else {
            // Fallback one earlier versions
            usernameLabel.text = follower.login
            avatarImageView.setImage(from: follower.avatarUrl)
        }
        
        
    }
    
    private func configure() {
        addSubViews(avatarImageView, usernameLabel)
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            // Avatar Image View Constraints
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            // Ensure square avatar image view
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            // Username Label Constraints
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
