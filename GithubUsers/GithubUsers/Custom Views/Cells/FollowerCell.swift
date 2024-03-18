//
//  FollowerCell.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/27/24.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    
    static let reuseID  = "FollowerCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        // Passes SwiftUI View for the cell
        contentConfiguration = UIHostingConfiguration { FollowerView(follower: follower) }
    }
}
