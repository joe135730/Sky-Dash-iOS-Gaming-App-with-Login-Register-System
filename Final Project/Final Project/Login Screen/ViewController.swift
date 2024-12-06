import UIKit
import FirebaseAuth
import FirebaseFirestore

class ViewController: UIViewController {
    let loginView = LoginScreenView()
    let mainScreen = MainScreenView()
    
    var contactsList = [Contact]()
    var handleAuth: AuthStateDidChangeListenerHandle?
    var currentUser:FirebaseAuth.User?
    let childProgressView = ProgressSpinnerViewController()
    
    let database = Firestore.firestore()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
    }


    //MARK: viewWillAppear, Lifecycle method where handle logic before the screen is loaded
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        //MARK: handleAuth is a authentication state change listener, used for tracking whether any user is signed in
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
                // do nothing
            } else {
                self.currentUser = user
                //MARK: setting the profile photo
                /*
                if let url = self.currentUser?.photoURL{
                    //self.RankingScreenViewCell.profilePic.loadRemoteImage(from: url)
                }
                */
                
                //MARK: Observe Firestore database to display the contacts list...
                self.database.collection("users")
                    .document((self.currentUser?.email)!)
                    .collection("contacts")
                    .addSnapshotListener(includeMetadataChanges: false, listener: {querySnapshot, error in
                                                
                        if let documents = querySnapshot?.documents{
                            self.contactsList.removeAll()
                            for document in documents{
                                do{
                                    let contact  = try document.data(as: Contact.self)
                                    self.contactsList.append(contact)
                                }catch{
                                    print(error)
                                }
                            }
                            self.contactsList.sort(by: {$0.name < $1.name})
                            print(self.contactsList)
                            //self.mainScreen.tableViewContacts.reloadData()
                            // MARK: modify here
                           if let mainScreenController = self.navigationController?.topViewController as? MainScreenController {
                               mainScreenController.contactsList = self.contactsList
                               //mainScreenController.tableViewContacts.reloadData()
                               self.mainScreen.tableViewContacts.reloadData()
                           }
                        }
                    })
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sky Dash Login"
        
        // Check if token exists in UserDefaults
        let defaults = UserDefaults.standard
        
        if let savedToken = defaults.string(forKey: "sessionToken") {
            // If token is found, set it to User.token and navigate to the main screen
            UserToken.token = savedToken
            print("User is already logged in with token: \(savedToken)")
            
            // Navigate to MainScreen
            let mainScreenController = MainScreenController()
            self.navigationController?.pushViewController(mainScreenController, animated: false)
            
        } else {
            // Setup the sign-up and login buttons if not logged in
            loginView.signUpButton.addTarget(self, action: #selector(onSignUpBarButtonTapped), for: .touchUpInside)
            loginView.loginButton.addTarget(self, action: #selector(onLoginUpBarButtonTapped), for: .touchUpInside)
        }
    }
    
    //MARK: viewWillDisappear, Lifecyccle where handle the logic right before the screen disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handleAuth!)
    }
}

