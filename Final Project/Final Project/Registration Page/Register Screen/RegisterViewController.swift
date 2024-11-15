//
//  RegisterViewController.swift
//  Final Project
//
//  Created by YHY on 11/10/24.
//
import UIKit
import PhotosUI
import FirebaseStorage

class RegisterViewController: UIViewController {
    //var delegate:ViewController!
    let registerView = RegisterView()
    let childProgressView = ProgressSpinnerViewController()
    
    let storage = Storage.storage()
    var pickedImage:UIImage?
    
    override func loadView() {
        view = registerView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SKY DASH"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold),
            .foregroundColor: UIColor.systemYellow
        ]
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        //add menu to button take selfie
        registerView.buttonTakeSelfie.menu = getImagePicker()
        
        registerView.buttonSignUp.addTarget(self, action: #selector(onRegisterTapped), for: .touchUpInside)
        //title = "Register"
    }
    
    //MARK: menu for buttonTakeSelfie setup...
    func getImagePicker() -> UIMenu{
        let menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.usingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.photoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take selfie using Camera...
    func usingCamera(){
        let CameraProtocol = UIImagePickerController()
        CameraProtocol.sourceType = .camera
        CameraProtocol.allowsEditing = true
        CameraProtocol.delegate = self
        present(CameraProtocol, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func photoFromGallery(){
        //create configuratoin for the picker
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        //set photo picker's delegate to itself to enable this screen to handle the PHPicker
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    @objc func onRegisterTapped(){
        //MARK: creating a new user on Firebase with photo...
        showActivityIndicator()
        uploadProfilePhotoStorage()
    }
    
    //MARK: Sign Up success
    func showSignUpSuccessInAlert(){
            //MARK: show alert...
            let message = "Click ok to login"
            let alert = UIAlertController(title: "Sigin Up Succeed", message: message, preferredStyle: .alert)
            //MARK: Click ok to go back to login page
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
        
            self.present(alert, animated: true)
    }
    
    //MARK: Validations
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    func showPasswordNotEqualAlert() {
        let alert = UIAlertController(title: "Error!", message: "Password is not equal!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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

