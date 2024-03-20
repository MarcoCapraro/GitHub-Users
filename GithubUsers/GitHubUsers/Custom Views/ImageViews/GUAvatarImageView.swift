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
        
        // Rounded Edges, Clips Image to Container, Sets Default Image (in case it cant be downloaded)
        layer.cornerRadius      = 10
        clipsToBounds           = true
        image                   = placeholderImage
    }
    
    // Makes network call to download image (or use cached image)
    func setImage(from urlString: String) {
//        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
//            guard let self = self else { return }
//            DispatchQueue.main.async { self.image = image }
//        }
        
        // Don't have try keyword because there is no need to catch errors
        Task { image = await NetworkManager.shared.downloadImage(from: urlString) ?? placeholderImage }
    }
}
