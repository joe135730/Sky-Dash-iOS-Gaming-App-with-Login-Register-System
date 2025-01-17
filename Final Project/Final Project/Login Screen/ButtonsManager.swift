import UIKit
import FirebaseAuth

extension ViewController{
    @objc func onSignUpBarButtonTapped() {
        let registerScreenController = RegisterScreenController()
        self.navigationController?.pushViewController(registerScreenController,animated: true)
    }

    @objc func onLoginUpBarButtonTapped() {
        print("login button tapped")
        self.showActivityIndicator()
        
        if let email = loginView.textFieldEmail.text,
           let password = loginView.textFieldPassword.text {
            if email.isEmpty || password.isEmpty {
                self.hideActivityIndicator()
                showEmptyAlert()
            } else if !isValidEmail(email) {
                self.hideActivityIndicator()
                showInvalidEmailAlert()
            } else {
                performLogin(email: email, password: password)
            }
        } else {
            self.hideActivityIndicator()
        }
    }
    
    func performLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            
            // Always hide the activity indicator when the async operation completes
            defer {
                DispatchQueue.main.async {
                    self.hideActivityIndicator()
                }
            }
            
            if error == nil {
                let homePageViewController = HomePageViewController()
                self.navigationController?.pushViewController(homePageViewController, animated: true)
            } else {
                let alert = UIAlertController(
                    title: "Error!",
                    message: "Incorrect Password or User not found!",
                    preferredStyle: .alert
                )
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }

    func showEmptyAlert() {
        let alert = UIAlertController(title: "Error!", message: "Fields cannot be empty!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showInvalidEmailAlert() {
        let alert = UIAlertController(title: "Error!", message: "Invalid Email!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
