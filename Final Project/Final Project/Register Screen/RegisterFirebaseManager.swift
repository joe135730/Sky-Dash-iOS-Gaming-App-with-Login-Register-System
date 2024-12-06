import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

extension RegisterScreenController {
    func registerNewAccount() {
        self.showActivityIndicator()
        
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text {
            
            // Upload profile photo and register user
            uploadProfilePhotoToStorage()
        }
    }
    
    func uploadProfilePhotoToStorage() {
        var profilePhotoURL: URL?
        if let image = pickedImage {
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                let imagesRepo = storage.reference().child("imagesUsers")
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg")
                
                let uploadTask = imageRef.putData(jpegData, completion: { (metadata, error) in
                    if error == nil {
                        imageRef.downloadURL(completion: { (url, error) in
                            if error == nil {
                                profilePhotoURL = url
                                self.registerUser(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        } else {
            registerUser(photoURL: profilePhotoURL)
        }
    }
    
    func registerUser(photoURL: URL?) {
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
                if error == nil {
                    self.setNameAndPhotoOfTheUserInFirebaseAuth(name: name, email: email, photoURL: photoURL)
                } else {
                    print("Error creating user: \(String(describing: error))")
                }
            })
        }
    }
    
    func setNameAndPhotoOfTheUserInFirebaseAuth(name: String, email: String, photoURL: URL?) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = name
        changeRequest?.photoURL = photoURL
        
        changeRequest?.commitChanges(completion: { (error) in
            if error == nil {
                let friend = Contact(name: name, email: email, score: 0, phototURL: photoURL?.absoluteString)
                self.saveFriendToFirestore(friend: friend)
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Error occurred: \(String(describing: error))")
            }
        })
    }
    
    func saveFriendToFirestore(friend: Contact) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        
        // Save user information to the users collection
        let userRef = db.collection("users").document(friend.email)
        
        do {
            try userRef.setData(from: friend) { error in
                if let error = error {
                    print("Error saving user to Firestore: \(error.localizedDescription)")
                } else {
                    print("User successfully saved to Firestore.")
                    
                    // Create empty initial contact data
                    let initialContactData: [String: Any] = [
                        "name": friend.name,
                        "email": friend.email,
                        "lastMessage": "",
                        "lastMessageTime": Date(),
                        //"score": friend.score,
                        //"photoURL": friend.photoURL ?? ""
                    ]
                    
                    // Create a contact collection for new users
                    let contactsRef = db.collection("users")
                        .document(friend.email)
                        .collection("contacts")
                    
                    // Add an empty contact document
                    contactsRef.document().setData(initialContactData) { error in
                        if let error = error {
                            print("Error creating initial contacts: \(error.localizedDescription)")
                        } else {
                            print("Initial contacts created successfully")
                        }
                    }
                }
            }
        } catch {
            print("Error encoding friend data: \(error.localizedDescription)")
        }
    }
}
