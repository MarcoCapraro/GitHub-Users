//
//  FollowersListVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/13/24.
//

import UIKit

class FollowersListVC: UIViewController {
    
    // This is the data that will be passed to this view
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
            case . success(let followers):
                print(followers)

            case .failure(let err):
                self.presentGUAlertOnMainThread(alertTitle: "Bad Stuff", message: err.rawValue, buttonTitle: "Ok")
            }
                        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
