//
//  RegisterFirebaseManager.swift
//  Final Project
//
//  Created by YHY on 11/15/24.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

extension RegisterViewController{
    func registerPlayer(photoURL: URL?){
        if let name = registerView.textFieldName.text,
           let email = registerView.textFieldEmail.text,
           let password = registerView.textFieldPassword.text,
           let confirmPassword = registerView.textFieldConfirmPassword.text,
           let userID = registerView.textFieldUserID.text{
            Auth.auth().createUser(withEmail: email, password: password,completion: { result, error in
                if error == nil{
                    self.setPlayerInfoInAuth(name: name, email:email, photoURL: photoURL)
                } else{
                    print(error)
                }
            })
            
        }
    }
    
    func uploadProfilePhotoStorage(){
        var profilePhotoURL: URL?
        
        if let image = pickedImage{
            if let jpegData = image.jpegData(compressionQuality: 80){ // get jped image from picked image
                let storageRef = storage.reference() // initiate firebase storage
                let imagesRepo = storageRef.child("imagesUsers") // create new folker imagesUsers
                let imageRef = imagesRepo.child("\(NSUUID().uuidString).jpg") // create unique name for file
                
                let upload = imageRef.putData(jpegData, completion: {(metadata, error) in
                    if error == nil {
                        imageRef.downloadURL(completion: {(url, error) in // fetch the download URL of the uploaded image
                            if error == nil{
                                profilePhotoURL = url // save URL locally in variable profilePhotoURL
                                self.registerPlayer(photoURL: profilePhotoURL)
                            }
                        })
                    }
                })
            }
        }
        else {
            registerPlayer(photoURL: profilePhotoURL)
        }
    }
    
    func setPlayerInfoInAuth(name: String, email: String, photoURL: URL?){
        let changeInfo = Auth.auth().currentUser?.createProfileChangeRequest()
        changeInfo?.displayName = name
        changeInfo?.photoURL = photoURL
        print("\(photoURL)")
        
        changeInfo?.commitChanges(completion: {(error) in
            if error == nil{
                self.hideActivityIndicator()
                self.navigationController?.popViewController(animated: true)
            }
            else{
                print("Error: \(String(describing: error))")
            }
        })
    }
    
}
