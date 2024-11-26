//
//  DisplayUserProfileController.swift
//  WA8_40
//
//  Created by jocw on 11/27/24.
//

import UIKit

class DisplayUserProfileController: UIViewController {
    
    let displayUserProfileView = DisplayUserProfileView()
    
    override func loadView() {
        view = displayUserProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up any button targets here if needed
        displayUserProfileView.editProfileButton.addTarget(self, action: #selector(onEditProfileTapped), for: .touchUpInside)
    }
    
    @objc func onEditProfileTapped() {
        let editProfileController = EditUserProfileController()
        self.navigationController?.pushViewController(editProfileController, animated: true)
    }
}
