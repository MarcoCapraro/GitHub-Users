//
//  GUAvatarImageView.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/27/24.
//

import UIKit

class GUAvatarImageView: UIImageView {
    
    let cache               = NetworkManager.shared.cache
    let placeholderImage    = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configure
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius      = 10                // rounded edges
        clipsToBounds           = true              // clips avatar UIImage to bounds of UIImageView so it also conforms to rounded edges
        image                   = placeholderImage  // sets the default image view in case of no avatar to placeholder image
    }
    
    // Makes network call to download image (or use cached image)
    func setImage(from urlString: String) {
//        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async { self.image = image }
//        }
        
        // Don't need to mark try because we aren't worried about catching errors
        Task { image = await NetworkManager.shared.downloadImage(from: urlString) ?? placeholderImage }
    }
}
