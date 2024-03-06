//
//  GURepoItemVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/6/24.
//

import UIKit

class GURepoItemVC: GUItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Configuration for Subclass
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
