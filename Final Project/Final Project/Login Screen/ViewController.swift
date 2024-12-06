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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        //MARK: handling if the Authentication state is changed (sign in, sign out, register)...
        handleAuth = Auth.auth().addStateDidChangeListener{ auth, user in
            if user == nil{
            } else {
                self.currentUser = user
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
                           if let mainScreenController = self.navigationController?.topViewController as? MainScreenController {
                               mainScreenController.contactsList = self.contactsList
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

        let defaults = UserDefaults.standard
        
        if let savedToken = defaults.string(forKey: "sessionToken") {
            UserToken.token = savedToken
            print("User is already logged in with token: \(savedToken)")

            let mainScreenController = MainScreenController()
            self.navigationController?.pushViewController(mainScreenController, animated: false)
            
        } else {
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

