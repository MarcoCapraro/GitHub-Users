//
//  FollowersListVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/13/24.
//

import UIKit

class FollowersListVC: GUDataLoadingVC {
    
    enum Section { case main }
    
    // This is the data that will be passed to this view
    var username: String!
    var followers: [Follower]           = []
    var filteredFollowers: [Follower]   = []
    var page: Int                       = 1
    var hasMoreFollowers: Bool          = true
    var isSearching: Bool               = false
    var isLoadingMoreFollowers: Bool    = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewController()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if followers.isEmpty && !isLoadingMoreFollowers {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "person.slash")
            config.text = "No Followers"
            config.secondaryText = "This user has no followers. Go follow them!"
            contentUnavailableConfiguration = config
        } else if isSearching && filteredFollowers.isEmpty {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        // Initialize collection view to use
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        // Register the FollowerCell to use for each cell in the collection view
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        // Structured Concurrency (Top-Bottom Structure)
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                updateUI(with: followers)
                dismissLoadingView()
                isLoadingMoreFollowers = false
            } catch {
                // handle errors
                if let guError = error as? GUError {
                    presentGUAlert(alertTitle: "Bad Stuff Happened", message: guError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                
                isLoadingMoreFollowers = false
                dismissLoadingView()
            }
            
//            guard let followers = try? await NetworkManager.shared.getFollowers(for: username, page: page) else {
//                presentDefaultAlert()
//                dismissLoadingView()
//                return
//            }
//            
//            updateUI(with: followers)
//            dismissLoadingView()
        }
        
        
//        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//            
//            switch result {
//            case . success(let followers):
//                self.updateUI(with: followers)
//                
//            case .failure(let err):
//                self.presentGUAlertOnMainThread(alertTitle: "Bad Stuff", message: err.rawValue, buttonTitle: "Ok")
//            }
//            
//            isLoadingMoreFollowers = false
//                        
//        }
    }
    
    func updateUI(with followers: [Follower]) {
        // There would be a strong reference to FollowersListVC because of self, but weak self declared in getFollowers
        if(followers.count < 100) { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        self.updateData(on: followers)
        setNeedsUpdateContentUnavailableConfiguration()

    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        // Takes snapshot of current data and then one of the new data and converges them
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let guError = error as? GUError {
                    presentGUAlert(alertTitle: "Something Went Wrong", message: guError.rawValue, buttonTitle: "Ok")
                } else {
                    presentDefaultAlert()
                }
                
                dismissLoadingView()
            }
        }
        
//        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//            
//            switch result {
//            case .success(let user):
//                self.addUserToFavorites(user: user)
//                
//            case .failure(let error):
//                self.presentGUAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
//            }
//            
//        }
    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                DispatchQueue.main.async {
                    self.presentGUAlert(alertTitle: "Success!", message: "You have successfully favorited this user", buttonTitle: "Hooray!")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.presentGUAlert(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}

extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // offsetY (scroll distance), contentHeight (height of entire collection), height (screen height)
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        // Determines if you've reached the end of your scroll (last page of followers)
        if(offsetY > contentHeight - height) {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers: followers
        let follower    = activeArray[indexPath.item]
        
        let destVC      = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowersListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            setNeedsUpdateContentUnavailableConfiguration()
            return
        }
        isSearching = true
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

extension FollowersListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        // Reset the state of FollowersListVC screen
        self.username   = username
        title           = username
        page            = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        navigationItem.searchController?.searchBar.text = ""
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)

        // Set to new user
        getFollowers(username: username, page: page)
    }
    
}

#Preview {
    FollowersListVC(username: "MarcoCapraro")
}
