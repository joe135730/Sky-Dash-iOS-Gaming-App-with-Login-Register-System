import UIKit
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class RegisterScreenController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let registerView = RegisterScreenView()
    let childProgressView = ProgressSpinnerViewController()
    //MARK: variable to store the picked Image...
    var pickedImage:UIImage?
    
    //MARK: storage
    let storage = Storage.storage()
    
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        registerView.signUpButton.addTarget(self, action: #selector(onSignUpBarButtonTapped), for: .touchUpInside)
        
        //MARK: adding menu to buttonTakePhoto...
        registerView.buttonTakePhoto.menu = getMenuImagePicker()
    }
    
    //MARK: set the profile photo
    func getMenuImagePicker() -> UIMenu{
        var menuItems = [
            UIAction(title: "Camera",handler: {(_) in
                self.pickUsingCamera()
            }),
            UIAction(title: "Gallery",handler: {(_) in
                self.pickPhotoFromGallery()
            })
        ]
        
        return UIMenu(title: "Select source", children: menuItems)
    }
    
    //MARK: take Photo using Camera...
    func pickUsingCamera(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    //MARK: pick Photo using Gallery...
    func pickPhotoFromGallery(){
        var configuration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.any(of: [.images])
        configuration.selectionLimit = 1
        
        let photoPicker = PHPickerViewController(configuration: configuration)
        
        photoPicker.delegate = self
        present(photoPicker, animated: true, completion: nil)
    }
    
    
    @objc func onSignUpBarButtonTapped() {
        if let name = registerView.textFieldName.text,
            let email = registerView.textFieldEmail.text,
            let password = registerView.textFieldPassword.text,
            let confirmPassword = registerView.textFieldConfirmPassword.text {
            
            if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                self.showEmptyAlert()
            } else if password != confirmPassword {
                self.showPasswordNotEqualAlert()
            } else if !isValidEmail(email) {
                self.showInvalidEmailAlert()
            } else {
                //MARK: Register new account through Firebase
                self.registerNewAccount()

                self.showSignUpSuccessInAlert()
                
                // Navigate to the HomePageController
               let homePageController = HomePageViewController()
               homePageController.selectedProfileImage = self.registerView.buttonTakePhoto.imageView?.image // Pass current profile image
               navigationController?.pushViewController(homePageController, animated: true)
                
                //MARK: creating a new user on Firebase with photo...
                showActivityIndicator()
                uploadProfilePhotoToStorage()

            }
        }
    }
    
    func showSignUpSuccessInAlert(){
            let message = "Click ok to login"
            let alert = UIAlertController(title: "Sigin Up Succeed", message: message, preferredStyle: .alert)
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

//MARK: adopting required protocols for PHPicker...
extension RegisterScreenController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        print(results)
        
        let itemprovider = results.map(\.itemProvider)
        
        for item in itemprovider{
            if item.canLoadObject(ofClass: UIImage.self){
                item.loadObject(ofClass: UIImage.self, completionHandler: { (image, error) in
                    DispatchQueue.main.async{
                        if let selectedImage = image as? UIImage{
                            self.registerView.buttonTakePhoto.setImage(
                                selectedImage.withRenderingMode(.alwaysOriginal),
                                for: .normal
                            )
                            self.pickedImage = selectedImage
                        }
                    }
                })
            }
        }
    }
}

