//
//  GUTextField.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/13/24.
//

import UIKit

class GUTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Custom Configuration
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Continous testing and tweaking to get to this style of button customization
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .go
        clearButtonMode             = .whileEditing
        placeholder                 = "Enter a username"
    }

}
