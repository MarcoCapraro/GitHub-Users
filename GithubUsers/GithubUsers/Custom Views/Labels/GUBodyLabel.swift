//
//  GUBodyLabel.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import UIKit

class GUBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        
        self.textAlignment = textAlignment
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        font = UIFont.preferredFont(forTextStyle: .body)
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        
    }

}
