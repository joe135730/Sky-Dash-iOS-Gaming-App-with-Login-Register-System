import UIKit

class RegisterScreenView: UIView {
    //MARK: Scroll view
    var contentWrapper: UIScrollView!

    var textFieldName:UITextField!
    var textFieldEmail:UITextField!
    var textFieldPassword:UITextField!
    var textFieldConfirmPassword:UITextField!
    
    var signUpButton: UIButton!
    //MARK: profile photo
    var buttonTakePhoto: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0,0,28)
        
        setUpContentWrapper()
        
        setupTextFieldName()
        setupTextFieldEmail()
        setupTextFieldPassword()
        setupTextFieldConfirmPassword()
        
        setupSiginUpButton()
        setupbuttonTakePhoto()
        
        initConstraints()
    }
    
    func setUpContentWrapper() {
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

    func setupTextFieldName() {
        textFieldName = UITextField()
        textFieldName.placeholder = "Username"
        textFieldName.translatesAutoresizingMaskIntoConstraints = false
        textFieldName.borderStyle = .roundedRect

        let nameAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemYellow
        ]
        textFieldName.attributedPlaceholder = NSAttributedString(string: "Username", attributes: nameAttributes)
        
        textFieldName.textColor = .systemYellow
        textFieldName.backgroundColor = .black
        textFieldName.layer.borderWidth = 1.0
        textFieldName.layer.borderColor = UIColor.white.cgColor
        textFieldName.layer.cornerRadius = 8.0
        contentWrapper.addSubview(textFieldName)
    }

    func setupTextFieldEmail() {
        textFieldEmail = UITextField()
        textFieldEmail.keyboardType = .emailAddress
        textFieldEmail.placeholder = "Email"
        textFieldEmail.translatesAutoresizingMaskIntoConstraints = false
        textFieldEmail.borderStyle = .roundedRect

        let emailAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemYellow
        ]
        textFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: emailAttributes)
        
        textFieldEmail.textColor = .systemYellow
        textFieldEmail.backgroundColor = .black
        textFieldEmail.layer.borderWidth = 1.0
        textFieldEmail.layer.borderColor = UIColor.white.cgColor
        textFieldEmail.layer.cornerRadius = 8.0
        contentWrapper.addSubview(textFieldEmail)
    }

    func setupTextFieldPassword() {
        textFieldPassword = UITextField()
        textFieldPassword.placeholder = "Password"
        textFieldPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldPassword.borderStyle = .roundedRect

        let passwordAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemYellow
        ]
        textFieldPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: passwordAttributes)
        
        textFieldPassword.textColor = .systemYellow
        textFieldPassword.backgroundColor = .black
        textFieldPassword.layer.borderWidth = 1.0
        textFieldPassword.layer.borderColor = UIColor.white.cgColor
        textFieldPassword.layer.cornerRadius = 8.0
        textFieldPassword.isSecureTextEntry = true
        contentWrapper.addSubview(textFieldPassword)
    }

    func setupTextFieldConfirmPassword() {
        textFieldConfirmPassword = UITextField()
        textFieldConfirmPassword.placeholder = "Confirm Password"
        textFieldConfirmPassword.translatesAutoresizingMaskIntoConstraints = false
        textFieldConfirmPassword.borderStyle = .roundedRect

        let confirmAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemYellow
        ]
        textFieldConfirmPassword.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: confirmAttributes)
        
        textFieldConfirmPassword.textColor = .systemYellow
        textFieldConfirmPassword.backgroundColor = .black
        textFieldConfirmPassword.layer.borderWidth = 1.0
        textFieldConfirmPassword.layer.borderColor = UIColor.white.cgColor
        textFieldConfirmPassword.layer.cornerRadius = 8.0
        textFieldConfirmPassword.isSecureTextEntry = true
        contentWrapper.addSubview(textFieldConfirmPassword)
    }
    
    func setupbuttonTakePhoto(){
        buttonTakePhoto = UIButton(type: .system)
        buttonTakePhoto.setTitle("", for: .normal)
        buttonTakePhoto.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        buttonTakePhoto.contentHorizontalAlignment = .fill
        buttonTakePhoto.contentVerticalAlignment = .fill
        buttonTakePhoto.imageView?.contentMode = .scaleAspectFit
        buttonTakePhoto.showsMenuAsPrimaryAction = true
        buttonTakePhoto.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonTakePhoto)
    }

    func setupSiginUpButton() {
        signUpButton = UIButton(type: .system)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        signUpButton.backgroundColor = .systemYellow
        signUpButton.layer.cornerRadius = 10.0
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(signUpButton)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            textFieldName.topAnchor.constraint(equalTo: self.contentWrapper.topAnchor, constant: 32),
            textFieldName.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            textFieldName.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 40),
            textFieldName.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -40),
            
            textFieldEmail.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 12),
            textFieldEmail.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            textFieldEmail.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 40),
            textFieldEmail.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -40),
            
            textFieldPassword.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 12),
            textFieldPassword.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            textFieldPassword.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 40),
            textFieldPassword.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -40),
            
            textFieldConfirmPassword.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 12),
            textFieldConfirmPassword.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            textFieldConfirmPassword.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 40),
            textFieldConfirmPassword.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -40),
            
            buttonTakePhoto.topAnchor.constraint(equalTo: textFieldConfirmPassword.bottomAnchor, constant: 12),
            buttonTakePhoto.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            buttonTakePhoto.widthAnchor.constraint(equalToConstant: 50),
            buttonTakePhoto.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: buttonTakePhoto.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: self.contentWrapper.centerXAnchor),
            signUpButton.leadingAnchor.constraint(equalTo: self.contentWrapper.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: self.contentWrapper.trailingAnchor, constant: -40),
            signUpButton.bottomAnchor.constraint(lessThanOrEqualTo: self.contentWrapper.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

