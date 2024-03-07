//
//  GUFollowerItemVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/6/24.
//

import UIKit

class GUFollowerItemVC: GUItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Configuration for Subclass
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
