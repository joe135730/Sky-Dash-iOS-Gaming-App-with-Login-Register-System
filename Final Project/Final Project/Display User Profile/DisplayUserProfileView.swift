import UIKit

class DisplayUserProfileView: UIView {
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var editProfileButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0, 0, 28)
        
        setupTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupEditProfileButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Display User Profile"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.textColor = .systemYellow
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupEmailTextField() {
        emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.isUserInteractionEnabled = false // read-only
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emailTextField)
    }

    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isUserInteractionEnabled = false // read-only
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
    }
    
    func setupEditProfileButton() {
        editProfileButton = UIButton(type: .system)
        editProfileButton.setTitle("Edit Profile", for: .normal)
        editProfileButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        editProfileButton.setTitleColor(.black, for: .normal)
        editProfileButton.backgroundColor = .systemYellow
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(editProfileButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 85),
            emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -85),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 85),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -85),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            editProfileButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            editProfileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            editProfileButton.widthAnchor.constraint(equalToConstant: 150),
            editProfileButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
