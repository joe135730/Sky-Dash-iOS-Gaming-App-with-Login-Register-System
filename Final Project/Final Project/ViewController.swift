//
//  ViewController.swift
//  Final Project
//
//  Created by Che-Yi Wu on 2024/10/16.
//

import UIKit

class ViewController: UIViewController {
    let loginView = LoginView()
    let userProfileView = UserProfileView()
    let editProfileView = EditProfileView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // type something
        // Handle navigation to UserProfileView
        loginView.userProfileButton.addTarget(self, action: #selector(showUserProfile), for: .touchUpInside)
        
        // Handle navigation to EditProfileView
        userProfileView.editProfileButton.addTarget(self, action: #selector(showEditProfile), for: .touchUpInside)
        
        // Handle confirm button action in EditProfileView (e.g., go back to UserProfileView)
        editProfileView.confirmButton.addTarget(self, action: #selector(confirmEdit), for: .touchUpInside)
    }

    @objc func showUserProfile() {
        view = userProfileView
        title = "User Profile"
    }
    
    @objc func showEditProfile() {
        view = editProfileView
        title = "Edit Profile"
    }
    
    @objc func confirmEdit() {
        view = userProfileView
        title = "User Profile"
    }

}

