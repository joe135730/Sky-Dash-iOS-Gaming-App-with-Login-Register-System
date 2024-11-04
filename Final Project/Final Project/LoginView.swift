import UIKit

class LoginView: UIView {
    var loginButton: UIButton!
    var userProfileButton: UIButton!
    var viewRankingButton: UIButton! // New button to view the ranking
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        // Initializing buttons
        setupLoginButton()
        setupUserProfileButton()
        setupViewRankingButton()
        
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
    
    func setupViewRankingButton() {
        viewRankingButton = UIButton(type: .system)
        viewRankingButton.setTitle("View Ranking", for: .normal)
        viewRankingButton.translatesAutoresizingMaskIntoConstraints = false
        viewRankingButton.backgroundColor = .systemBlue
        viewRankingButton.setTitleColor(.white, for: .normal)
        viewRankingButton.layer.cornerRadius = 5
        self.addSubview(viewRankingButton)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            loginButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            loginButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            // User Profile Button below the Login Button
            userProfileButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            userProfileButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            userProfileButton.heightAnchor.constraint(equalToConstant: 50),
            userProfileButton.widthAnchor.constraint(equalToConstant: 200),
            
            // View Ranking Button below the User Profile Button
            viewRankingButton.topAnchor.constraint(equalTo: userProfileButton.bottomAnchor, constant: 20),
            viewRankingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewRankingButton.heightAnchor.constraint(equalToConstant: 50),
            viewRankingButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
