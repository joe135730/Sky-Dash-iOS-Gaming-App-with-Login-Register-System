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
        displayUserProfileView.emailTextField.text = currentUser.email
        
        // Always show the password as "******"
        displayUserProfileView.passwordTextField.text = "****************"
    }
}
