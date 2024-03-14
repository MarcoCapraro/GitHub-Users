//
//  GURepoItemVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/6/24.
//

import UIKit

// Define delegate protocol in the class that is sending the message
// Extend the protocol in the class that is receiving the message
protocol GURepoItemVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

class GURepoItemVC: GUItemInfoVC {
    
    weak var delegate: GURepoItemVCDelegate!
    
    init(user: User, delegate: GURepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
