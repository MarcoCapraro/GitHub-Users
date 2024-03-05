//
//  GUSecondaryTitleLabel.swift
//  GithubUsers
//
//  Created by Marco Capraro on 3/5/24.
//

import UIKit

class GUSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        
    }
}
