//
//  SearchVC.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/9/24.
//

import UIKit

class SearchVC: UIViewController {
    
    // UI Components on SearchVC
    let logoImageView       = UIImageView()
    let usernameTextField   = GUTextField()
    let callToActionButton  = GUButton(backgroundColor: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    
    // Computed property to determine state of usernameTextField
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubViews(logoImageView, usernameTextField, callToActionButton)
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Reset view to default state whenever reappearing
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        // UIView.endEditing - causes the embedded text field to resign when the view is tapped
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceTypes.isHeight568 || DeviceTypes.isHeight667Zoomed ? 20 : 80
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func pushFollowerListVC() {
        // Ensure valid input from text field (determines push)
        guard isUsernameEntered else {
            presentGUAlert(alertTitle: "Empty Username", message: "Please enter a username. We need to know who to look for 😁", buttonTitle: "Ok")
            return
        }
        
        usernameTextField.resignFirstResponder()
        let followersListVC = FollowersListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followersListVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Called when the user selects return from GUTextField or GUButton is tapped
        pushFollowerListVC()
        return true
    }
}

#Preview {
    SearchVC()
}
