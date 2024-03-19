//
//  GUItemInfoView.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/6/24.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GUItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel      = GUTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GUTitleLabel(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom Configuration
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubViews(symbolImageView, titleLabel, countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            
            // Square image pinned to top left of container
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // Same Y position as the symbolImageView, but centered with container
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            // Directly below symbolImageView, but centered with the container
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
        ])
    }
    
    func set(itemInfoType: ItemInfoType, with count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image   = SFSymbols.repos
            titleLabel.text         = "Public Repos"
        case .gists:
            symbolImageView.image   = SFSymbols.gists
            titleLabel.text         = "Public Gists"
        case .followers:
            symbolImageView.image   = SFSymbols.followers
            titleLabel.text         = "Followers"
        case .following:
            symbolImageView.image   = SFSymbols.following
            titleLabel.text         = "Following"
        }
        
        countLabel.text = String(count)
    }
    
}
