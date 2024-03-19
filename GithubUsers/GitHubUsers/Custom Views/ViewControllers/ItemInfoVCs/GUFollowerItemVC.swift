//
//  GUFollowerItemVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/6/24.
//

import UIKit

// Define delegate protocol in the class that is sending the message
// Extend the protocol in the class that is receiving the message
protocol GUFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GUFollowerItemVC: GUItemInfoVC {
    
    weak var delegate: GUFollowerItemVCDelegate!
    
    init(user: User, delegate: GUFollowerItemVCDelegate) {
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
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
