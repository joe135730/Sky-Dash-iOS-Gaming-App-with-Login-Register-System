import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegistrationPageViewController: UIViewController {
    let registrationPage = RegistrationPageView()
    var contactsList = [Contact]()
    
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let database = Firestore.firestore()
    
    override func loadView() {
        view = registrationPage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SKY DASH"
        //set title font and color
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.systemYellow
        ]
        
        registrationPage.buttonLogin.addTarget(self, action: #selector(onLoginTapped), for: .touchUpInside)
        
        registrationPage.buttonSignUp.addTarget(self, action: #selector(onSignupTapped), for: .touchUpInside)
        

    }

    //MARK: lifecycle handle before the screen is loaded
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        //MARK: handling if the Authentication state is changed(sign in, sign out, register)
        handleAuth = Auth.auth().addStateDidChangeListener{auth, user in
            // no sign-in user
            if user == nil{
                self.currentUser = nil
                self.registrationPage.buttonSignUp.isEnabled =  false
                self.registrationPage.buttonSignUp.isHidden = true
                
                //MARK: Reset friendlist?
                self.contactsList.removeAll()
                
            }
            else{
                //user is logged in
                self.currentUser = user
                self.registrationPage.buttonSignUp.isEnabled = true
                self.registrationPage.buttonSignUp.isHidden = false
                
            }
        }
    }
    
    @objc func onLoginTapped(){
        let LoginVC = LoginViewController()
        //LoginVC.currentUser = self.currentUser
        navigationController?.pushViewController(LoginVC, animated: true)
        
    }

    @objc func onSignupTapped(){
        let RegisterVC = RegisterViewController()
        navigationController?.pushViewController(RegisterVC, animated: true)
    }
}

