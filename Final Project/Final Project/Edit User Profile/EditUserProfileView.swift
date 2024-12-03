import UIKit

class EditUserProfileView: UIView {

    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0, 0, 28)
        
        setupTitleLabel()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmButton()
        
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Edit Profile"
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
        passwordTextField.placeholder = "New Password"
        passwordTextField.isSecureTextEntry = true  // Add secure text entry
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
    }

    func setupConfirmButton() {
        confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        confirmButton.setTitleColor(.black, for: .normal) // Change text color to black
        confirmButton.backgroundColor = .systemYellow  // Change button background to system yellow
        confirmButton.layer.cornerRadius = 5
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmButton)
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
            
            confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmButton.widthAnchor.constraint(equalToConstant: 120),
            confirmButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
