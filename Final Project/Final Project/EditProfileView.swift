import UIKit

class EditProfileView: UIView {
    
    var titleLabel: UILabel!
    var playerNameLabel: UILabel!
    var passwordTextField: UITextField!
    var confirmButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        
        setupTitleLabel()
        setupPlayerNameLabel()
        setupPasswordTextField()
        setupConfirmButton()
        
        initConstraints()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Edit Profile"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .yellow
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
    }
    
    func setupPlayerNameLabel() {
        playerNameLabel = UILabel()
        playerNameLabel.text = "Player Name: John"
        playerNameLabel.textColor = .yellow
        playerNameLabel.textAlignment = .center
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playerNameLabel)
    }
    
    func setupPasswordTextField() {
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .white
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(passwordTextField)
    }
    
    func setupConfirmButton() {
        confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.backgroundColor = .yellow
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(confirmButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // Title label at the top
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Player name label below the title
            playerNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            playerNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            // Password text field below player name label
            passwordTextField.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 20),
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            // Confirm button below password text field
            confirmButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            confirmButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
