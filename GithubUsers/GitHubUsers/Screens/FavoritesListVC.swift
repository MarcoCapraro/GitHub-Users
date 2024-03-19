//
//  FavoritesListVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/9/24.
//

import UIKit

class FavoritesListVC: GUDataLoadingVC {
    
    let tableView               = UITableView()
    var favorites: [Follower]   = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewController()
        configureTableView()
    }
    
    // Ensure that mid-session favorites can be refreshed
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "star")
            config.text = "No Favorites"
            config.secondaryText = "Add a favorite on the follower list screen"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites() {
        // Get favorites list from UserDefaults via PersistenceManager
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return  }
            switch result {
            case.success(let favorites):
                self.updateUI(with: favorites)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGUAlert(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            }
        }
    }
    
    func updateUI(with favorites: [Follower]) {
        // Populate favorites array or show empty state
        self.favorites = favorites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            self.tableView.reloadData()
            // Edge case, in case empty state is put ontop of tableView (prevents)
            self.view.bringSubviewToFront(self.tableView)
        }
    }

}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite    = favorites[indexPath.row]
        
        cell.set(favorite: favorite)
        return cell
    }
    
    // When selecting a favorite user, present their followers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite    = favorites[indexPath.row]
        let destVC      = FollowersListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    // Setup swipe to delete favorite user
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                // Everything is fine (no error)
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                setNeedsUpdateContentUnavailableConfiguration()
                return
            }
            
            DispatchQueue.main.async {
                self.presentGUAlert(alertTitle: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
}
