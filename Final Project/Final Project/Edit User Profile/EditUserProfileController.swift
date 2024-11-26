//
//  EditUserProfileController.swift
//  WA8_40
//
//  Created by jocw on 11/27/24.
//

import UIKit

class EditUserProfileController: UIViewController {
    
    let editUserProfileView = EditUserProfileView()
    
    override func loadView() {
        view = editUserProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up any button targets here if needed
        editUserProfileView.confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
    }
    
    @objc func onConfirmTapped() {
        // Handle confirm button tap
        navigationController?.popViewController(animated: true)
    }
}
