import UIKit

class LoginView: UIView {
    var loginButton: UIButton!
    var userProfileButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        // Initializing buttons
        setupLoginButton()
        setupUserProfileButton()
        
        // Setting up constraints
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoginButton(){
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        loginButton.imageView?.contentMode = .scaleAspectFit
        loginButton.showsMenuAsPrimaryAction = true
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func setupUserProfileButton() {
        userProfileButton = UIButton(type: .system)
        userProfileButton.setTitle("Go to User Profile", for: .normal)
        userProfileButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(userProfileButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            userProfileButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            userProfileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            userProfileButton.heightAnchor.constraint(equalToConstant: 50),
            userProfileButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
