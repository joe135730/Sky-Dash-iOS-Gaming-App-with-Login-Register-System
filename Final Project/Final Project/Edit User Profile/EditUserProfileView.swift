import UIKit

class EditUserProfileView: UIView {

    var titleLabel: UILabel!
    var playerNameLabel: UILabel!
    var passwordTextField: UITextField!
    var confirmButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .rgb(0,0,28)  // Match the dark blue background
        
        setupTitleLabel()
        setupPlayerNameLabel()
        setupPasswordTextField()
        setupConfirmButton()
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Edit Profile"
        titleLabel.font = .boldSystemFont(ofSize: 32)  // Match the font size
        titleLabel.textColor = .white  // Match the text color
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }

    func setupPlayerNameLabel() {
        playerNameLabel = UILabel()
        playerNameLabel.text = "Email: "
        playerNameLabel.textColor = .white  // Match the text color
        playerNameLabel.font = .systemFont(ofSize: 16)
        playerNameLabel.textAlignment = .center
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playerNameLabel)
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
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .systemBlue  // Match the button style
        confirmButton.layer.cornerRadius = 5
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            playerNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            playerNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            playerNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
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
