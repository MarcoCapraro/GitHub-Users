//
//  FavoritesListVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/9/24.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case.success(let favorites):
                print(favorites)
            case .failure(let error):
                break
                
            }
        }
    }

}
