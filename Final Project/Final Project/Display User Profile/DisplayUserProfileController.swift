import UIKit
import FirebaseAuth
import FirebaseFirestore

class DisplayUserProfileController: UIViewController {
    
    let displayUserProfileView = DisplayUserProfileView()
    let database = Firestore.firestore()
    
    override func loadView() {
        view = displayUserProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserProfile()
        
        // Set up any button targets here if needed
        displayUserProfileView.editProfileButton.addTarget(self, action: #selector(onEditProfileTapped), for: .touchUpInside)
    }
    
    @objc func onEditProfileTapped() {
        let editProfileController = EditUserProfileController()
        self.navigationController?.pushViewController(editProfileController, animated: true)
    }
    
    func fetchUserProfile() {
        guard let currentUser = Auth.auth().currentUser else {
            print("No user is logged in.")
            return
        }
        
        // Set the email field to the current user's email
        displayUserProfileView.userNameTextField.text = currentUser.email
        
        // Always show the password as "******"
        displayUserProfileView.passwordTextField.text = "******"
    }
}
