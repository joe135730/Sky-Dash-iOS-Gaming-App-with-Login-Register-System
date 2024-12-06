import UIKit
import FirebaseAuth

class EditUserProfileController: UIViewController {
    
    let editUserProfileView = EditUserProfileView()
    let auth = Auth.auth()
    
    override func loadView() {
        view = editUserProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        fetchUserEmail()
        
        // Set up button target
        editUserProfileView.confirmButton.addTarget(self, action: #selector(onConfirmTapped), for: .touchUpInside)
    }
    
    func fetchUserEmail() {
        guard let currentUser = auth.currentUser else {
            print("No user is logged in.")
            return
        }
        // Display current user's email
        editUserProfileView.emailTextField.text = "\(currentUser.email ?? "")"
    }
    
    @objc func onConfirmTapped() {
        guard let newPassword = editUserProfileView.passwordTextField.text, !newPassword.isEmpty else {
            showAlert(title: "Error", message: "Password cannot be empty.")
            return
        }
        
        // Update the password in Firebase Authentication
        auth.currentUser?.updatePassword(to: newPassword, completion: { error in
            if let error = error {
                print("Error updating password: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "Failed to update password.")
            } else {
                print("Password updated successfully.")
                self.showAlert(title: "Success", message: "Password updated successfully.")
            }
        })
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if title == "Success" {
                // Pop back to HomePageViewController
                self.navigationController?.popViewController(animated: true)
            }
        })
        present(alert, animated: true)
    }

}
