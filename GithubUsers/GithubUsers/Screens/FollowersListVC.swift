//
//  FollowersListVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/13/24.
//

import UIKit

class FollowersListVC: UIViewController {
    
    enum Section { case main }
    
    // This is the data that will be passed to this view
    var username: String!
    var followers: [Follower] = []
    var page: Int = 1
    var hasMoreFollowers: Bool = true
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
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
    
    func getFollowers(username: String, page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            // Make sure self isn't optional to use without unwrapping below
            guard let self = self else { return }
            
            switch result {
            case . success(let followers):
                if(followers.count < 100) { self.hasMoreFollowers = false }
                // Strong reference to FollowersListVC because of self, need to make sure weak reference (shown above)
                self.followers.append(contentsOf: followers)
                self.updateData()

            case .failure(let err):
                self.presentGUAlertOnMainThread(alertTitle: "Bad Stuff", message: err.rawValue, buttonTitle: "Ok")
            }
                        
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData() {
        // Takes snapshot of current data and then one of the new data and converges them
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

}

extension FollowersListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // offsetY (scroll distance), contentHeight (height of entire collection), height (screen height)
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Determines if you've reached the end of your scroll (last page of followers)
        if(offsetY > contentHeight - height) {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
